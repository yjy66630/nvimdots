local lang = {}

lang["fatih/vim-go"] = {
	lazy = true,
	ft = "go",
	build = ":GoInstallBinaries",
	config = require("lang.vim-go"),
}
lang["simrat39/rust-tools.nvim"] = {
	lazy = true,
	ft = "rust",
	config = require("lang.rust-tools"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["Saecki/crates.nvim"] = {
	lazy = true,
	event = "BufReadPost Cargo.toml",
	config = require("lang.crates"),
	dependencies = { "nvim-lua/plenary.nvim" },
}
lang["iamcco/markdown-preview.nvim"] = {
	lazy = true,
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
	ft = "markdown",
	build = ":call mkdp#util#install()",
}

lang["chrisbra/csv.vim"] = {
	lazy = true,
	ft = "csv",
}
lang["Civitasv/cmake-tools.nvim"] = {
	lazy = true,
-- 	event = "CmdlineEnter",
	event = "CmdUndefined",
-- 	event = {"VeryLazy"},
	config = require("lang.cmake-tools"),
}
lang["CRAG666/code_runner.nvim"] = {
	lazy = true,
	event = "CmdlineEnter",
	-- config = require("configs.runner.runner"),
	config = [[{
	  filetype = {
	    java = {
	      "cd $dir &&",
	      "javac $fileName &&",
	      "java $fileNameWithoutExt"
	    },
	    python = "python3 -u",
	    c++ = "g++ $fileName -o $fileNameWithoutExt", 
	    c = "gcc $fileName -o $fileNameWithoutExt",
	    typescript = "deno run",
	    rust = {
	      "cd $dir &&",
	      "rustc $fileName &&",
	      "$dir/$fileNameWithoutExt"
	    },
	  },
	}]]
}
return lang
