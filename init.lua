if not vim.g.vscode then
	-- 禁用clever-f默认设置
	vim.g.clever_f_not_overwrites_standard_mappings = 1
	require("core")
else
    -- Bootstrap plugins manager
    local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.uv.fs_stat(lazy_path) then
        local out = vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            "--branch=stable",
            "https://github.com/folke/lazy.nvim.git",
            lazy_path,
        })
        if vim.v.shell_error ~= 0 then
            vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
            }, true, {})
            vim.fn.getchar()
            os.exit(1)
        end
    end
    vim.opt.rtp:prepend(lazy_path)

    -- Load user configs before load plugins
    require("vscode-neovim.config")

    require("lazy").setup({
    -- Load plugin specifics in directories
    spec = {
        { import = "vscode-neovim/plugins" }
    },
    performance = {
        rtp = {
        disabled_plugins = {
            "gzip",
            "matchit",
            "matchparen",
            "netrwPlugin",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
        },
        },
    },
    })
end
