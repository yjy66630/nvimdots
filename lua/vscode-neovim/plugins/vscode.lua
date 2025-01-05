return { -- {
--     "rainbowhxch/accelerated-jk.nvim"
-- }
{
    "rhysd/clever-f.vim",
    lazy = true,
    event = {"CursorHold", "CursorHoldI"},
    config = function()
        vim.api.nvim_set_hl(0, "CleverChar", {
            underline = true,
            bold = true,
            fg = "Orange",
            bg = "NONE",
            ctermfg = "Red",
            ctermbg = "NONE"
        })
        vim.g.clever_f_mark_char_color = "CleverChar"
        vim.g.clever_f_mark_direct_color = "CleverChar"
        vim.g.clever_f_mark_direct = true
        vim.g.clever_f_timeout_ms = 1500
    end
}, {
    "tpope/vim-surround",
    lazy = true,
    event = "BufRead"
}, {
    "m4xshen/autoclose.nvim",
    lazy = true,
    event = "InsertEnter",
    keys = {
        ["("] = {
            escape = false,
            close = true,
            pair = "()"
        },
        ["["] = {
            escape = false,
            close = true,
            pair = "[]"
        },
        ["{"] = {
            escape = false,
            close = true,
            pair = "{}"
        },

        ["<"] = {
            escape = true,
            close = true,
            pair = "<>",
            enabled_filetypes = {"rust"}
        },
        [">"] = {
            escape = true,
            close = false,
            pair = "<>"
        },
        [")"] = {
            escape = true,
            close = false,
            pair = "()"
        },
        ["]"] = {
            escape = true,
            close = false,
            pair = "[]"
        },
        ["}"] = {
            escape = true,
            close = false,
            pair = "{}"
        },

        ['"'] = {
            escape = true,
            close = true,
            pair = '""'
        },
        ["`"] = {
            escape = true,
            close = true,
            pair = "``"
        },
        ["'"] = {
            escape = true,
            close = true,
            pair = "''",
            disabled_filetypes = {"rust"}
        }
    },
    options = {
        disabled_filetypes = {"big_file_disabled_ft"},
        disable_when_touch = false
    }
}, {
    "easymotion/vim-easymotion",
    lazy = true,
    event = "InsertEnter"
}, {
    "tommcdo/vim-exchange",
    lazy = true,
    event = "BufRead"
}, {
    "chrisgrieser/nvim-spider",
    lazy = true,
    event = "CursorMoved",
    opts = {
        keys = {{ -- example for lazy-loading and keymap
            "e",
            "<cmd>lua require('spider').motion('e')<CR>",
            mode = {"n", "o", "x"}
        }}
    }
}, {
    "wellle/targets.vim",
    lazy = true,
    event = "BufRead"
}, {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        highlight = {
            enable = false
        },
        indent = {
            enable = false
        }
    }
}, 
}
