local editor = {}

editor["rainbowhxch/accelerated-jk.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("editor.accelerated-jk"),
}
editor["olimorris/persisted.nvim"] = {
	lazy = true,
	cmd = {
		"SessionToggle",
		"SessionStart",
		"SessionStop",
		"SessionSave",
		"SessionLoad",
		"SessionLoadLast",
		"SessionLoadFromFile",
		"SessionDelete",
	},
	config = require("editor.persisted"),
}
editor["m4xshen/autoclose.nvim"] = {
	lazy = true,
	event = "InsertEnter",
	config = require("editor.autoclose"),
}
editor["max397574/better-escape.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.better-escape"),
}
editor["LunarVim/bigfile.nvim"] = {
	lazy = false,
	config = require("editor.bigfile"),
	cond = require("core.settings").load_big_files_faster,
}
editor["ojroques/nvim-bufdel"] = {
	lazy = true,
	cmd = { "BufDel", "BufDelAll", "BufDelOthers" },
}
editor["rhysd/clever-f.vim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.cleverf"),
}
editor["numToStr/Comment.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.comment"),
}
editor["sindrets/diffview.nvim"] = {
	lazy = true,
	cmd = { "DiffviewOpen", "DiffviewClose" },
}
editor["junegunn/vim-easy-align"] = {
	lazy = true,
	cmd = "EasyAlign",
}
editor["smoka7/hop.nvim"] = {
	lazy = true,
	version = "*",
	event = { "CursorHold", "CursorHoldI" },
	config = require("editor.hop"),
}
editor["romainl/vim-cool"] = {
	lazy = true,
	event = { "CursorMoved", "InsertEnter" },
}
editor["lambdalisue/suda.vim"] = {
	lazy = true,
	cmd = { "SudaRead", "SudaWrite" },
	config = require("editor.suda"),
}

editor["tommcdo/vim-exchange"] = {
	lazy = true,
	event = "BufRead",
}
editor["tpope/vim-surround"] = {
	lazy = true,
	event = "BufRead",
}
editor["wellle/targets.vim"] = {
	lazy = true,
	event = "BufRead",
}
editor["chrisgrieser/nvim-spider"] = {
    lazy = true,
	event = "CursorMoved",
    opts = {
              keys = {
                { -- example for lazy-loading and keymap
                    "e",
                    "<cmd>lua require('spider').motion('e')<CR>",
                    mode = { "n", "o", "x" },
                },
            },
    },
}
editor["Badhi/nvim-treesitter-cpp-tools"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("editor.cpp-tools"),
}
----------------------------------------------------------------------
--                  :treesitter related plugins                    --
----------------------------------------------------------------------
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
	"JoosepAlviste/nvim-ts-context-commentstring",
	event = {"VeryLazy"},
	config = require("editor.ts-context-commentstring"),
}
editor["nvim-treesitter/nvim-treesitter"] = {
	lazy = true,
	build = function()
		if #vim.api.nvim_list_uis() ~= 0 then
			vim.api.nvim_command("TSUpdate")
		end
	end,
	event = "BufAdd",
	-- event = "BufReadPost",
	config = require("editor.treesitter"),
	dependencies = {
		{ "mfussenegger/nvim-treehopper" },
		{ "nvim-treesitter/nvim-treesitter-textobjects" },
		{
			"abecodes/tabout.nvim",
			config = require("editor.tabout"),
		},
		{
			"windwp/nvim-ts-autotag",
			config = require("editor.autotag"),
		},
		{
			"NvChad/nvim-colorizer.lua",
			config = require("editor.colorizer"),
		},
		{
			"hiphish/rainbow-delimiters.nvim",
			config = require("editor.rainbow_delims"),
		},
	},
}

return editor
