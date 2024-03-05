local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key
local su = require("modules.utils.snip_utils")
local cp = su.copy
local tr = su.transform
local rx_tr = su.regex_transform
local jt = su.join_text
local nl = su.new_line
local te = su.trig_engine
local ae = su.args_expand
local c_py = su.code_python
local c_viml = su.code_viml
local c_shell = su.code_shell
local make_actions = su.make_actions

ls.filetype_extend("cpp", { "c" })

ls.add_snippets("cpp", {
	s({ trig = "vector", dscr = '(vector) "std::vector (v)"' }, {
		t("std::vector<"),
		i(1, "char", { key = "i1" }),
		t("> "),
		i(0, "", { key = "i0" }),
		t(";"),
	}),
	s({ trig = "deque", dscr = "(deque)" }, {
		t("std::deque<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "forward_list", dscr = "(flist)" }, {
		t("std::forward_list<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "list", dscr = "(list)" }, {
		t("std::list<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "set", dscr = "(set)" }, {
		t("std::set<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "map", dscr = '(map) "std::map (map)"' }, {
		t("std::map<"),
		i(1, "key", { key = "i1" }),
		t(", "),
		i(2, "value", { key = "i2" }),
		t("> map"),
		i(0, "", { key = "i0" }),
		t(";"),
	}),
	s({ trig = "multiset", dscr = "(mset)" }, {
		t("std::multiset<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "multimap", dscr = "(multimap)" }, {
		t("std::multimap<"),
		i(1, "Key", { key = "i1" }),
		t(", "),
		i(2, "T", { key = "i2" }),
		t("> "),
		i(3, "", { key = "i3" }),
		t(";"),
	}),
	s({ trig = "unordered_set", dscr = "(unordered_set)" }, {
		t("std::unordered_set<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "unordered_map", dscr = "(unordered_map)" }, {
		t("std::unordered_map<"),
		i(1, "Key", { key = "i1" }),
		t(", "),
		i(2, "T", { key = "i2" }),
		t("> "),
		i(3, "", { key = "i3" }),
		t(";"),
	}),
	s({ trig = "unordered_multiset", dscr = "(unordered_multiset)" }, {
		t("std::unordered_multiset<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "unordered_multimap", dscr = "(unordered_multimap)" }, {
		t("std::unordered_multimap<"),
		i(1, "Key", { key = "i1" }),
		t(", "),
		i(2, "T", { key = "i2" }),
		t("> "),
		i(3, "", { key = "i3" }),
		t(";"),
	}),
	s({ trig = "stack", dscr = "(stack)" }, {
		t("std::stack<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "queue", dscr = "(queue)" }, {
		t("std::queue<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "priority_queue", dscr = "(priority_queue)" }, {
		t("std::priority_queue<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(";"),
	}),
	s({ trig = "make_shared", dscr = "make_shared(msp)" }, {
		t("std::shared_ptr<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(" = std::make_shared<"),
		cp(1),
		t(">("),
		i(3, "", { key = "i3" }),
		t(");"),
	}),
	s({ trig = "auto make_shared", dscr = "(auto_make_shared)" }, {
		t("auto "),
		i(1, "", { key = "i1" }),
		t(" = std::make_shared<"),
		i(2, "T", { key = "i2" }),
		t(">("),
		i(3, "", { key = "i3" }),
		t(");"),
	}),
	s({ trig = "make_unique", dscr = "(make_unique)" }, {
		t("std::unique_ptr<"),
		i(1, "T", { key = "i1" }),
		t("> "),
		i(2, "", { key = "i2" }),
		t(" = std::make_unique<"),
		cp(1),
		t(">("),
		i(3, "", { key = "i3" }),
		t(");"),
	}),
	s({ trig = "amup", dscr = "(amup)" }, {
		t("auto "),
		i(1, "", { key = "i1" }),
		t(" = std::make_unique<"),
		i(2, "T", { key = "i2" }),
		t(">("),
		i(3, "", { key = "i3" }),
		t(");"),
	}),
	s({ trig = "namespace", dscr = '(ns) "namespace .. (namespace)"' }, {
		t("namespace "),
		d(1, function(args, snip)
			return sn(nil, {
				i(1, "namespace", { key = "i1" }),
			})
		end),
		nl(),
		t("{"),
		nl(),
		t("\t"),
		i(0, "", { key = "i0" }),
		nl(),
		t("} /*"),
		cp(1),
		t("*/"),
	}),
	s({ trig = "cout", dscr = "(cout)" }, {
		t("std::cout << "),
		i(1, "", { key = "i1" }),
		t(" << std::endl;"),
	}),
	s({ trig = "cin", dscr = "(cin)" }, {
		t("std::cin >> "),
		i(1, "", { key = "i1" }),
		t(";"),
	}),
	s({ trig = "static_cast", dscr = "(static_cast)" }, {
		t("static_cast<"),
		i(1, "unsigned", { key = "i1" }),
		t(">("),
		i(2, "expr", { key = "i2" }),
		t(")"),
		i(3, "", { key = "i3" }),
	}),
	s({ trig = "dynamic_cast", dscr = "(dynamic_cast)" }, {
		t("dynamic_cast<"),
		i(1, "unsigned", { key = "i1" }),
		t(">("),
		i(2, "expr", { key = "i2" }),
		t(")"),
		i(3, "", { key = "i3" }),
	}),
	s({ trig = "reinterpret_cast", dscr = "(reinterpret_cast)" }, {
		t("reinterpret_cast<"),
		i(1, "unsigned", { key = "i1" }),
		t(">("),
		i(2, "expr", { key = "i2" }),
		t(")"),
		i(3, "", { key = "i3" }),
	}),
	s({ trig = "const_cast", dscr = "(const_cast)" }, {
		t("const_cast<"),
		i(1, "unsigned", { key = "i1" }),
		t(">("),
		i(2, "expr", { key = "i2" }),
		t(")"),
		i(3, "", { key = "i3" }),
	}),
	s({ trig = "fori", dscr = "(fori)"}, {
		t("for (int "),
		i(2, "i", { key = "i2" }),
		t(" = 0; "),
		cp(2),
		t(" < "),
		i(1, "count", { key = "i1" }),
		t("; "),
		cp(2),
		i(3, "++", { key = "i3" }),
		t(") {"),
		nl(),
		t("\t"),
		i(0, "/* code */", { key = "i0" }),
		nl(),
		t("}"),
	}),
	s({ trig = "fora", dscr = "(fore)" }, {
		t("for ("),
		i(1, "auto", { key = "i1" }),
		t(" "),
		i(2, "i", { key = "i2" }),
		t(" : "),
		i(3, "container", { key = "i3" }),
		t(") {"),
		nl(),
		t("\t"),
		i(4, "", { key = "i4" }),
		nl(),
		t("}"),
	}),

	s({ trig = "forr", dscr = '(itera) "Auto iterator"' }, {
		t("for (auto "),
		i(1, "i", { key = "i1" }),
		t(" = "),
		cp(1),
		t(".begin(); "),
		cp(1),
		t(" != "),
		cp(1),
		t(".end(); ++"),
		cp(1),
		t(") {"),
		nl(),
		t("\t"),
		i(0),
		nl(),
		t("}"),
	}),
	s({ trig = "using", dscr = '(using) "using namespace"' }, {
		t("using namespace "),
		i(1, "std", { key = "i1" }),
		t(";"),
		i(0),
	}),
})
