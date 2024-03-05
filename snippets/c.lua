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

ls.add_snippets("c", {
	s("class", {
		-- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
		c(1, {
			t("public "),
			t("private "),
		}),
		t("class "),
		i(2),
		t(" "),
		c(3, {
			t("{"),
			-- sn: Nested Snippet. Instead of a trigger, it has a position, just like insert-nodes. !!! These don't expect a 0-node!!!!
			-- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
			sn(nil, {
				t("extends "),
				i(1),
				t(" {"),
			}),
			sn(nil, {
				t("implements "),
				i(1),
				t(" {"),
			}),
		}),
		t({ "", "\t" }),
		i(0),
		t({ "", "}" }),
	}),

	-- #

	s("#if", {
		t("#if "),
		i(1, "1"),
		t({ "", "" }),
		i(0),
		t({ "", "#endif // " }),
		f(function(args)
			return args[1]
		end, 1),
	}),

	s({ trig = "#inc", dscr = '(inc) "#include <> (inc)"' }, {
		t("#include <"),
		i(1, ".h", { key = "i1" }),
		t(">"),
	}),

	s({ trig = "#Inc", dscr = '(inc) #include ""' }, {
		t('#include "'),
		i(1, ".h", { key = "i1" }),
		t('"'),
	}),

	s({ trig = "#ifndef", dscr = "(ndef)" }, {
		t("#ifndef "),
		f(function(args, snip)
			return args[1]
		end, 1),
		t({ "", "\t#define " }),
		i(1, "SYMBOL", { key = "i1" }),
		t({ "", "#endif /* ifndef " }),
		f(function(args, snip)
			return args[1]
		end, 1),
		t({ " */", "" }),
		i(0),
	}),

	s({ trig = "#def", dscr = '(def) "#define ..."' }, {
		t("#define "),
		i(1, "", { key = "i1" }),
	}),

	s({ trig = "#ifdef", dscr = "(ifdef)" }, {
		t("#ifdef "),
		i(1, "FOO", { key = "i1" }),
		t({ "", "" }),
		t("\t"),
		i(2, "define ", { key = "i2" }),
		t({ "", "" }),
		t({ "#endif", "" }),
		i(0),
	}),

	s({ trig = "main", dscr = '(main) "main() (main)"' }, {
		t({ "int main(int argc, char *argv[])", "" }),
		t({ "{", "" }),
		t("\t"),
		i(0, { "/* code */" }, { key = "i0" }),
		t({ "", "\treturn 0;", "" }),
		t({ "}", "" }),
	}),

	-- if and else
	s({ trig = "if", dscr = '(if) "if .. (if)"' }, {
		t("if ("),
		i(1, "/* condition */", { key = "i1" }),
		t(") {"),
		t({ "", "" }),
		t("\t"),
		i(0, "/* code */", { key = "i0" }),
		t({ "", "" }),
		t("}"),
	}),

	s({ trig = "ife", dscr = '(ife) "if .. else"' }, {
		t("if ("),
		i(1, "/* condition */", { key = "i1" }),
		t(") {"),
		t({ "", "" }),
		t("\t"),
		i(2, "/* code */", { key = "i0" }),
		t({ "", "" }),
		t("}"),
		t({ "", "" }),
		t("else {"),
		t({ "", "\t" }),
		i(0),
		t({ "", "" }),
		t("}"),
	}),

	s({ trig = "else", dscr = "(else)" }, {
		t("else {"),
		t({ "", "" }),
		t("\t"),
		i(1),
		t({ "", "" }),
		t("}"),
	}),

	s({ trig = "elif", dscr = '(elif) "else if"' }, {
		t("else if ("),
		i(1, "/* condition */", { key = "i1" }),
		t(") {"),
		t({ "", "" }),
		t("\t"),
		i(0, "/* code */", { key = "i0" }),
		t({ "", "" }),
		t("}"),
	}),

	-- switch
	s({ trig = "switch", dscr = "switch \n\tcase: \n default:" }, {
		t("switch ("),
		i(1, "/* condition */", { key = "i1" }),
		t({ ")", "\t" }),
		t("case "),
		i(2, "/* enum */", { key = "i2" }),
		t(":"),
		i(3),
		t({ "", "\t\t" }),
		t({ "break;", "\t" }),
		t({ "default: ", "\t\t" }),
		i(0),
	}),

	s({ trig = "case", dscr = "switch \n\tcase: \n default:" }, {
		t("case "),
		i(1, "/* enum */", { key = "i2" }),
		t({ ":", "\t" }),
		i(0),
	}),

	-- for
	s({ trig = "for", dscr = '(for) "for int loop (fori)"' }, {
		t("for ("),
		i(1, "int i = 0"),
		t("; "),
		i(2, "i < N"),
		t("; "),
		i(3, "i++"),
		t({ ") {", "" }),
		t({ "\t" }),
		i(0),
		t({ "", "}" }),
	}),
	s({ trig = "while", dscr = "(while)" }, {
		t("while ("),
		i(1, "/* condition */", { key = "i1" }),
		t({ ") {", "" }),
		t({ "\t" }),
		i(0),
		t({ "", "}" }),
	}),
	s({ trig = "do", dscr = "(do while)" }, {
		t({ "do {", "" }),
		t("\t"),
		i(1),
		t({ "", "} while (" }),
		i(0, "/* condition */"),
		t(");"),
	}),

	--function
	s({ trig = "fund(%d+)", dscr = '(fund) "function declaration"', regTrig = true }, {
		t("/** \\brief "),
		i(1, "Brief function dscription here"),
		t({ "", "" }),
		t({ " *", "" }),
		t({ " *  " }),
		i(2, "Detailed dscription of the function"),
		t({ "", "" }),
		t({ " *", "" }),

		d(3, function(args, snip)
			local nodes = {}
			for iter = 1, tonumber(snip.captures[1]) do
				table.insert(nodes, t(" * \\param "))
				table.insert(nodes, i(iter * 2 - 1, "Parameter" .. iter))
				table.insert(nodes, t(" "))
				table.insert(nodes, i(iter * 2, "Description" .. iter))
				table.insert(nodes, t({ "", "" }))
			end
			table.insert(nodes, t(" * \\return "))
			table.insert(nodes, i(tonumber(snip.captures[1]) * 2 + 1, "Return parameter dscription"))
			table.insert(nodes, t({ "", " */", "" }))
			return sn(nil, nodes)
		end),

		d(4, function(args, snip)
			local nodes = {}
			table.insert(nodes, i(1, "void"))
			table.insert(nodes, t(" "))
			table.insert(nodes, i(2, "function_name"))
			table.insert(nodes, t(" ( "))
			table.insert(nodes, i(3, "Parameters"))
			table.insert(nodes, t({ " );", "" }))
			return sn(nil, nodes)
		end),
	}),

	s({ trig = "fun(%d+)", dscr = '(fun) "function implementation"', regTrig = true }, {
		d(1, function(args, snip)
			local nodes = {}
			table.insert(nodes, i(1, "void"))
			table.insert(nodes, t(" "))
			table.insert(nodes, i(2, "function_name"))
			table.insert(nodes, t(" ( "))

			local i_counter = 2
			for iter = 1, tonumber(snip.captures[1]) do
				table.insert(nodes, i(i_counter + 1, "Type" .. i_counter / 2))
				table.insert(nodes, t(" "))
				table.insert(nodes, i(i_counter + 2, "Parameter" .. i_counter / 2))
				if iter < tonumber(snip.captures[1]) then
					table.insert(nodes, t(", "))
				end
				i_counter = i_counter + 2
			end
			table.insert(nodes, t({ ") {", "\t" }))
			table.insert(nodes, i(i_counter + 1, "/*code at here*/"))
			table.insert(nodes, t({ "", "}" }))
			return sn(nil, nodes)
		end),
	}),
	-- head
	s({ trig = "head", descr = '(head) "File Header"' }, {
		t("/******************************************************************************"),
		nl(),
		t("* File:             "),
		f(function(args, snip)
			return snip.env.TM_FILENAME
		end),
		nl(),
		t("*"),
		nl(),
		t("* Author:           "),
		i(1, "", { key = "i2" }),
		t("  "),
		nl(),
		t("* Created:          "),
		f(function(args, snip)
			return c_shell("date +%m/%d/%y")
		end),
		t(" "),
		nl(),
		t("* Description:      "),
		d(2, function(args, snip)
			return sn(nil, { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, ""), { key = "i4" }) })
		end),
		nl(),
		t("*****************************************************************************/"),
		nl(),
		i(0, "", { key = "i0" }),
	}),
})
