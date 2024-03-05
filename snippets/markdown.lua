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
local fmt = extras.fmt
local m = extras.m
local l = extras.l
local postfix = require("luasnip.extras.postfix").postfix

ls.add_snippets("markdown", {
        s({trig = "tb(%d+)x(%d+)", regTrig = true}, {
        d(1, function(args, snip)
            local nodes = {}
            local i_counter = 0
            local hlines = ""
            for _ = 1, snip.captures[2] do
                i_counter = i_counter + 1
                table.insert(nodes, t("| "))
                table.insert(nodes, i(i_counter, "Column".. i_counter))
                table.insert(nodes, t(" "))
                hlines = hlines .. "|---"
            end
            table.insert(nodes, t{"|", ""})
            hlines = hlines .. "|"
            table.insert(nodes, t{hlines, ""})
            for _ = 1, snip.captures[1] do
                for _ = 1, snip.captures[2] do
                    i_counter = i_counter + 1
                    table.insert(nodes, t("| "))
                    table.insert(nodes, i(i_counter))
                    print(i_counter)
                    table.insert(nodes, t(" "))
                end
                table.insert(nodes, t{"|", ""})
            end
            return sn(nil, nodes)
        end)
    }),
})
