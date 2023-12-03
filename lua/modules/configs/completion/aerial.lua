return function()
	local kind_filter = {
		default = {
		"Class",
		"Constructor",
		"Enum",
		"Field",
		"Function",
		"Interface",
		"Method",
		"Module",
		"Namespace",
		"Package",
		"Property",
		"Struct",
		"Trait",
		},
		markdown = false,
		help = false,
		-- you can specify a different filter for each filetype
		lua = {
		"Class",
		"Constructor",
		"Enum",
		"Field",
		"Function",
		"Interface",
		"Method",
		"Module",
		"Namespace",
		-- "Package", -- remove package since luals uses it for control flow structures
		"Property",
		"Struct",
		"Trait",
		},
	}

	---@type table<string, string[]>|false
	local filter_kind = false
	if kind_filter then
		filter_kind = assert(vim.deepcopy(kind_filter))
		filter_kind._ = filter_kind.default
		filter_kind.default = nil
	end
	require("modules.utils").load_plugin("aerial", {
		lazy_load = false,
		backends = { "lsp", "markdown", "man" },
		close_on_select = true,
		highlight_on_jump = false,
		disable_max_lines = 8500,
		disable_max_size = 1000000,
		ignore = { filetypes = { "NvimTree", "terminal", "nofile" } },
		-- Use symbol tree for folding. Set to true or false to enable/disable
		-- Set to "auto" to manage folds if your previous foldmethod was 'manual'
		-- This can be a filetype map (see :help aerial-filetype-map)
		manage_folds = "auto",
		layout = {
			-- Determines the default direction to open the aerial window. The 'prefer'
			-- options will open the window in the other direction *if* there is a
			-- different buffer in the way of the preferred direction
			-- Enum: prefer_right, prefer_left, right, left, float
			default_direction = "prefer_right",
			min_width = 20,
			win_opts = {
            winhl = "Normal:NormalFloat,FloatBorder:NormalFloat,SignColumn:SignColumnSB",
            signcolumn = "yes",
            statuscolumn = " ",
          },
		},
		-- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
		-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
		-- Additionally, if it is a string that matches "actions.<name>",
		-- it will use the mapping at require("aerial.actions").<name>
		-- Set to `false` to remove a keymap
		keymaps = {
			["?"] = "actions.show_help",
			["g?"] = "actions.show_help",
			["<CR>"] = "actions.jump",
			["<2-LeftMouse>"] = "actions.jump",
			["<C-v>"] = "actions.jump_vsplit",
			["<C-s>"] = "actions.jump_split",
			["<C-d>"] = "actions.down_and_scroll",
			["<C-u>"] = "actions.up_and_scroll",
			["{"] = "actions.prev",
			["}"] = "actions.next",
			["[["] = "actions.prev_up",
			["]]"] = "actions.next_up",
			["q"] = "actions.close",
			["o"] = "actions.tree_toggle",
			["O"] = "actions.tree_toggle_recursive",
			["zr"] = "actions.tree_increase_fold_level",
			["zR"] = "actions.tree_open_all",
			["zm"] = "actions.tree_decrease_fold_level",
			["zM"] = "actions.tree_close_all",
			["zx"] = "actions.tree_sync_folds",
			["zX"] = "actions.tree_sync_folds",
		},
		-- A list of all symbols to display. Set to false to display all symbols.
		-- This can be a filetype map (see :help aerial-filetype-map)
		-- To see all available values, see :help SymbolKind
		filter_kind = {
			-- "Array",
			-- "Boolean",
			"Class",
			-- "Constant",
			"Constructor",
			"Enum",
			"EnumMember",
			"Event",
			-- "Field",
			-- "File",
			"Function",
			"Interface",
			"Key",
			"Method",
			"Module",
			"Namespace",
			-- "Null",
			-- "Number",
			"Object",
			"Operator",
			"Package",
			-- "Property",
			-- "String",
			"Struct",
			-- "TypeParameter",
			-- "Variable",
		},
		icons = {
			["File"] = " ",
			["Module"] = " ",
			["Namespace"] = " ",
			["Package"] = " ",
			["Class"] = " ",
			["Method"] = " ",
			["Property"] = " ",
			["Field"] = " ",
			["Constructor"] = " ",
			["Enum"] = " ",
			["Interface"] = " ",
			["Function"] = "󰡱 ",
			["Variable"] = " ",
			["Constant"] = " ",
			["String"] = "󰅳 ",
			["Number"] = "󰎠 ",
			["Boolean"] = " ",
			["Array"] = "󰅨 ",
			["Object"] = " ",
			["Key"] = " ",
			["Null"] = "󰟢 ",
			["EnumMember"] = " ",
			["Struct"] = " ",
			["Event"] = " ",
			["Operator"] = " ",
			["TypeParameter"] = " ",
		},
		show_guides = true,
		filter_kind = filter_kind,
		guides = {
          mid_item   = "├╴",
          last_item  = "└╴",
          nested_top = "│ ",
          whitespace = "  ",
        },
        post_jump_cmd = "normal! zz",
        close_on_select = true,

	})
end
