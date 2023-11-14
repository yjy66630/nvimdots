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
from __future__ import (absolute_import, division, print_function)


# The gdb.lookup_type() function is sometimes invoked from STL pretty printers
# for template arguments that can have cv-qualifiers / be pointers,
# which in turn confuses the builtin gdb.lookup_type() function.
#
# Here we monkey-patch the function to try a last resort approach of retrieving
# a type in a more generic yet hackish way.
def _patch_gdb_lookup_type():
    import gdb
    lookup_type_orig = gdb.lookup_type
    def lookup_type(type_str):
        try:
            return lookup_type_orig(type_str)
        except gdb.error as e:
            try:
                return gdb.parse_and_eval('(%s *) 0x0' % type_str).type.target()
            except gdb.error:
                raise e
    gdb.lookup_type = lookup_type

_patch_gdb_lookup_type()
del _patch_gdb_lookup_type
