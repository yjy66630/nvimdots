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

local function node_with_virtual_text(pos, node, text)
    local nodes
    if node.type == types.textNode then
        node.pos = 2
        nodes = {i(1), node}
    else
        node.pos = 1
        nodes = {node}
    end
    return sn(pos, nodes, {
		node_ext_opts = {
			active = {
				-- override highlight here ("GruvboxOrange").
				virt_text = {{text, "GruvboxOrange"}}
			}
		}
    })
end

local function nodes_with_virtual_text(nodes, opts)
    if opts == nil then
        opts = {}
    end
    local new_nodes = {}
    for pos, node in ipairs(nodes) do
        if opts.texts[pos] ~= nil then
            node = node_with_virtual_text(pos, node, opts.texts[pos])
        end
        table.insert(new_nodes, node)
    end
    return new_nodes
end

local function choice_text_node(pos, choices, opts)
    choices = nodes_with_virtual_text(choices, opts)
    return c(pos, choices, opts)
end

local ct = choice_text_node

-- see latex infinite list for the idea. Allows to keep adding arguments via choice nodes.
local function py_init()
  return
    sn(nil, c(1, {
      t(""),
      sn(1, {
        t(", "),
        i(1),
        d(2, py_init)
      })
    }))
end

-- splits the string of the comma separated argument list into the arguments
-- and returns the text-/insert- or restore-nodes
local function to_init_assign(args)
  local tab = {}
  local a = args[1][1]
  if #(a) == 0 then
    table.insert(tab, t({"", "\tpass"}))
  else
    local cnt = 1
    for e in string.gmatch(a, " ?([^,]*) ?") do
      if #e > 0 then
        table.insert(tab, t({"","\tself."}))
        -- use a restore-node to be able to keep the possibly changed attribute name
        -- (otherwise this function would always restore the default, even if the user
        -- changed the name)
        table.insert(tab, r(cnt, tostring(cnt), i(nil,e)))
        table.insert(tab, t(" = "))
        table.insert(tab, t(e))
        cnt = cnt+1
      end
    end
  end
  return
    sn(nil, tab)
end


ls.add_snippets("python", {
    -- head
	s({ trig = "head", descr = '(head) "File Header"' }, {
		t("///////////////////////////////////////////////////////////////////////////////"),
		nl(),
		t("// File:             "),
		f(function(args, snip)
			return snip.env.TM_FILENAME
		end),
		nl(),
		t("//"),
		nl(),
		t("// Author:           "),
		i(1, "", { key = "i2" }),
		t("  "),
		nl(),
		t("// Created:          "),
		f(function(args, snip)
			return c_shell("date +%m/%d/%y")
		end),
		t(" "),
		nl(),
		t("// Description:      "),
		d(2, function(args, snip)
			return sn(nil, { i(1, jt({ snip.env.LS_SELECT_DEDENT or {} }, ""), { key = "i4" }) })
		end),
		nl(),
		t("///////////////////////////////////////////////////////////////////////////////"),
		nl(),
		i(0, "", { key = "i0" }),
    }),

    s('fund', fmt([[
		def {func}({args}){ret}:
			{doc}{body}
	]], {
		func = i(1),
		args = i(2),
		ret = c(3, {
			t(''),
			sn(nil, {
				t(' -> '),
				i(1),
			}),
		}),
		doc = isn(4, {ct(1, {
			t(''),
			-- NOTE we need to surround the `fmt` with `sn` to make this work
			sn(1, fmt([[
			"""{desc}"""

			]], {desc = i(1)})),
			sn(2, fmt([[
			"""{desc}

			Args:
			{args}

			Returns:
			{returns}
			"""

			]], {
				desc = i(1),
				args = i(2),  -- TODO should read from the args in the function
				returns = i(3),
			})),
		}, {
			texts = {
				"(no docstring)",
				"(single line docstring)",
				"(full docstring)",
			}
		})}, "$PARENT_INDENT\t"),
		body = i(0),
	})),

	s("init", fmt(
		[[def __init__(self{}):{}]],
		{
			d(1, py_init),
			d(2, to_init_assign, {1})
		}
	))
})

