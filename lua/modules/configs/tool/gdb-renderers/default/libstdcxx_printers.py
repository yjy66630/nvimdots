# Copyright 2000-2018 JetBrains s.r.o.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import gdb

import re


from libstdcxx.v6.printers import (Iterator,
                                   unique_ptr_get)


class SmartPtrIterator(Iterator):
    "An iterator for smart pointer types with a single 'child' value"

    def __init__(self, val):
        self.val = val

    def __iter__(self):
        return self

    def __next__(self):
        if self.val is None:
            raise StopIteration
        self.val, val = None, self.val
        valtype = val.type
        if valtype.code == gdb.TYPE_CODE_PTR:
            valtype = valtype.target().strip_typedefs().pointer()
            val = val.cast(valtype)
        return ('get()', val)


# A hack around gcc8 child printing issues on Ubuntu (CPP-18972)
class StdPathPrinter:
    def __init__ (self, typename, val):
        self.val = val
        self.typename = typename
        try:
            impl = unique_ptr_get(self.val['_M_cmpts']['_M_impl'])
            self.type = impl.cast(gdb.lookup_type('uintptr_t')) & 3
            if self.type == 0:
                self.impl = impl
            else:
                self.impl = None
        except (gdb.error, ValueError):
            self.gcc8_hack = True

    def to_string (self):
        path = "%s" % self.val ['_M_pathname']
        if not hasattr(self, 'gcc8_hack'):
            if self.type != 0:
                t = self._path_type()
                if t:
                    path = '%s [%s]' % (path, t)
        return "filesystem::path %s" % path

    def __getattribute__ (self, name):
        if name == 'children' and hasattr(self, 'gcc8_hack'):
            raise AttributeError(name)
        else:
            return object.__getattribute__(self, name)


class StdChronoDurationPrinter:
    orig_to_string = None

    def to_string(self):
        s = StdChronoDurationPrinter.orig_to_string(self)
        return strip(s, 'std::chrono::duration = {', '}')


class StdChronoTimePointPrinter:
    prefix = re.compile(r'std::chrono::(?:\w+|[^{}=]+ time_point) = \{')
    orig_to_string = None

    def to_string(self, abbrev = None):
        if abbrev is not None:
            return StdChronoTimePointPrinter.orig_to_string(self, abbrev)
        s = StdChronoTimePointPrinter.orig_to_string(self)
        return strip(s, StdChronoTimePointPrinter.prefix, '}')


class StdChronoZonedTimePrinter:
    orig_to_string = None

    def to_string(self):
        s = StdChronoZonedTimePrinter.orig_to_string(self)
        return strip(s, 'std::chrono::zoned_time = {', '}')


class StdChronoTimeZonePrinter:
    orig_to_string = None

    def to_string(self):
        s = StdChronoTimeZonePrinter.orig_to_string(self)
        return strip(strip(s, self.typename), '=')


class StdChronoLeapSecondPrinter:
    orig_to_string = None

    def to_string(self):
        s = StdChronoLeapSecondPrinter.orig_to_string(self)
        return strip(strip(s, self.typename), '=')


class StdChronoTzdbPrinter:
    orig_to_string = None

    def to_string(self):
        s = StdChronoTzdbPrinter.orig_to_string(self)
        return strip(strip(s, self.typename), '=')


def strip(s, prefix, suffix=''):
    if isinstance(prefix, re.Pattern):
        match = prefix.match(s)
        start_matches = match is not None
        if start_matches:
            prefix = match.group()
    else:
        start_matches = s.startswith(prefix)

    if start_matches and s.endswith(suffix):
        return s[len(prefix):len(s)-len(suffix)].strip()
    return s


def patch_libstdcxx_printers_module():
    from libstdcxx.v6 import printers

    printers.SmartPtrIterator.__init__ = SmartPtrIterator.__init__
    printers.SmartPtrIterator.__iter__ = SmartPtrIterator.__iter__
    printers.SmartPtrIterator.__next__ = SmartPtrIterator.__next__

    if hasattr(printers, 'StdPathPrinter'):
        printers.StdPathPrinter.__init__ = StdPathPrinter.__init__
        printers.StdPathPrinter.__getattribute__ = StdPathPrinter.__getattribute__
        printers.StdPathPrinter.to_string = StdPathPrinter.to_string

    for patched_type in (StdChronoDurationPrinter,
                         StdChronoTimePointPrinter,
                         StdChronoZonedTimePrinter,
                         StdChronoTimeZonePrinter,
                         StdChronoLeapSecondPrinter,
                         StdChronoTzdbPrinter):
        name = patched_type.__name__
        orig_type = getattr(printers, name, None)
        if orig_type is not None:
            patched_type.orig_to_string = orig_type.to_string
            orig_type.to_string = patched_type.to_string
