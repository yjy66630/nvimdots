local tool = {}

tool["tpope/vim-fugitive"] = {
	lazy = true,
	cmd = { "Git", "G" },
}
-- only for fcitx5 user who uses non-English language during coding
-- tool["pysan3/fcitx5.nvim"] = {
-- 	lazy = true,
-- 	event = "BufReadPost",
-- 	cond = vim.fn.executable("fcitx5-remote") == 1,
-- 	config = require("tool.fcitx5"),
-- }
tool["nvim-tree/nvim-tree.lua"] = {
	lazy = true,
	cmd = {
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
	},
	config = require("tool.nvim-tree"),
}
tool["ibhagwan/smartyank.nvim"] = {
	lazy = true,
	event = "BufReadPost",
	config = require("tool.smartyank"),
}
tool["michaelb/sniprun"] = {
	lazy = true,
	-- You need to cd to `~/.local/share/nvim/site/lazy/sniprun/` and execute `bash ./install.sh`,
	-- if you encountered error about no executable sniprun found.
	build = "bash ./install.sh",
	cmd = "SnipRun",
	config = require("tool.sniprun"),
}
tool["akinsho/toggleterm.nvim"] = {
	lazy = true,
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualSelection",
	},
	config = require("tool.toggleterm"),
}
tool["folke/trouble.nvim"] = {
	lazy = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = require("tool.trouble"),
}
tool["folke/which-key.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("tool.which-key"),
}
tool["gelguy/wilder.nvim"] = {
	lazy = true,
	event = "CmdlineEnter",
	config = require("tool.wilder"),
	dependencies = { "romgrk/fzy-lua-native" },
}

tool["uga-rosa/translate.nvim"] = {
	lazy = true,
	event = "BufRead",
	config = require("tool.translate"),
}

tool["gennaro-tedesco/nvim-peekup"] = {
	lazy = true,
	event = "CmdlineEnter",
	config = require("tool.peekup"),
}

tool['tomasky/bookmarks.nvim'] = {
	lazy = true,
	event = "VimEnter",
	config = require('tool.bookmarks'),
}

tool['folke/todo-comments.nvim'] = {
	lazy = true,
	event = "BufReadPost",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = require('tool.todo-comments'),
}


----------------------------------------------------------------------
--                        Telescope Plugins                         --
----------------------------------------------------------------------
tool["nvim-telescope/telescope.nvim"] = {
	lazy = true,
	cmd = "Telescope",
	config = require("tool.telescope"),
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" },
		{ "nvim-lua/plenary.nvim" },
		{ "debugloop/telescope-undo.nvim" },
		{
			"ahmedkhalf/project.nvim",
			event = { "CursorHold", "CursorHoldI" },
			config = require("tool.project"),
		},
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-frecency.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' },
	},
}

----------------------------------------------------------------------
--                           DAP Plugins                            --
----------------------------------------------------------------------
tool["mfussenegger/nvim-dap"] = {
	lazy = true,
	cmd = {
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},
	config = require("tool.dap"),
	dependencies = {
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {"nvim-neotest/nvim-nio"},
			config = require("tool.dap.dapui"),
		},
		{ "jay-babu/mason-nvim-dap.nvim" },
		{
		    "theHamsta/nvim-dap-virtual-text",
		    dependencies = {
				'mfussenegger/nvim-dap',
				'nvim-treesitter/nvim-treesitter',
		    },
		    config = require("tool.dap.dap-virtual-text"),
		},
		{
          "rcarriga/cmp-dap",
          dependencies = { "nvim-cmp" },
          config = require("completion.cmp-dap"),
        },
        {
			"jbyuki/one-small-step-for-vimkind",
			-- stylua: ignore
			config = require("tool.dap.clients.lua"),
        },
	},
}

return tool
