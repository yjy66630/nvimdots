return function()
	local ls = require("luasnip")
	local types = require("luasnip.util.types")

	local snippet_path = vim.fn.stdpath("config") .. "/snippets"
	if not vim.tbl_contains(vim.opt.rtp:get(), snippet_path) then
		vim.opt.rtp:append(snippet_path)
	end

	require("modules.utils").load_plugin("luasnip", {
		history = true,
		update_events = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = {{"●", "RedItalic"}}
				}
			},
			[types.insertNode] = {
				active = {
					virt_text = {{"●", "BlueItalic"}}
				}
			}
		},
	}, false, require("luasnip").config.set_config)

	require("luasnip.loaders.from_lua").load({paths = snippet_path})
	require("luasnip.loaders.from_vscode").load({paths = snippet_path})
	require("luasnip.loaders.from_snipmate").load({paths = snippet_path})

	vim.keymap.set({"i", "s"}, "<C-E>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
	end, {silent = true})

-- 	require("luasnip.loaders.from_lua").lazy_load()
-- 	require("luasnip.loaders.from_vscode").lazy_load()
-- 	require("luasnip.loaders.from_snipmate").lazy_load()
end
