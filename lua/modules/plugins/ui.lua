local ui = {}

ui["goolord/alpha-nvim"] = {
	lazy = true,
	event = "BufWinEnter",
	config = require("ui.alpha"),
	dependencies = { { 'nvim-tree/nvim-web-devicons', 'ColaMint/pokemon.nvim' } }
}
ui["akinsho/bufferline.nvim"] = {
	lazy = true,
-- 	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	event = {"VeryLazy"},
	tag = "v4.5.2",
	config = require("ui.bufferline"),
}
ui["j-hui/fidget.nvim"] = {
	lazy = true,
	branch = "legacy",
	event = "LspAttach",
	config = require("ui.fidget"),
}
ui["lewis6991/gitsigns.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.gitsigns"),
}
ui["lukas-reineke/indent-blankline.nvim"] = {
	lazy = true,
-- 	event = { "CursorHold", "CursorHoldI" },
	event = {"VeryLazy"},
	config = require("ui.indent-blankline"),
}
ui["nvim-lualine/lualine.nvim"] = {
	lazy = true,
-- 	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	event = {"VeryLazy"},
	config = require("ui.lualine"),
}
ui["zbirenbaum/neodim"] = {
	lazy = true,
	event = "LspAttach",
	config = require("ui.neodim"),
}
ui["karb94/neoscroll.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.neoscroll"),
}
ui["rcarriga/nvim-notify"] = {
	lazy = true,
	event = "VeryLazy",
	config = require("ui.notify"),
}
ui["folke/paint.nvim"] = {
	lazy = true,
	event = { "CursorHold", "CursorHoldI" },
	config = require("ui.paint"),
}
ui["dstein64/nvim-scrollview"] = {
	lazy = true,
-- 	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	event = {"VeryLazy"},
	config = require("ui.scrollview"),
}
ui["lukas-reineke/headlines.nvim"] = {
	lazy = true,
	event = "VeryLazy",
	dependencies = "nvim-treesitter/nvim-treesitter",
	config = require("ui.headlines"),
}
ui["sainnhe/edge"] = {
 	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.edge"),
 }
 ui["folke/zen-mode.nvim"] = {
 	lazy = true,
	event = { "BufReadPost", "BufAdd", "BufNewFile" },
	config = require("ui.zen-mode"),
}

return ui
