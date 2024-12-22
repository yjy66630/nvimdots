local vscode = require("vscode-neovim")
vim.g.mapleader = " "
vim.notify = vscode.notify
vim.g.clipboard = vim.g.vscode_clipboard
-- Options
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.timeoutlen = 500
vim.opt.shortmess = "oOtTWIcCFS"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 8
vim.opt.virtualedit = "block"
vim.opt.jumpoptions = "stack"
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.smartindent = true
vim.opt.formatoptions = "tcrqjnl"
vim.opt.clipboard = "unnamedplus"
vim.cmd.syntax("off")

vim.keymap.set("n", "<", "<<", {})
vim.keymap.set("n", ">", ">>", {})

local function vscode_action(cmd)
    return function()
        vscode.action(cmd)
    end
end

-- Editor: buffers
vim.keymap.set("n", "tp", vscode_action("workbench.action.previousEditorInGroup"), {
    desc = "Previous Editor"
})
vim.keymap.set("n", "tq", vscode_action("workbench.action.closeActiveEditor"), {
    desc = "Close Editor"
})
vim.keymap.set("n", "tn", vscode_action("workbench.action.nextEditorInGroup"), {
    desc = "Next Editor"
})
vim.keymap.set("n", "t0", vscode_action("workbench.action.lastEditorInGroup"), {
    desc = "Last Editor"
})
vim.keymap.set("n", "t1", vscode_action("workbench.action.openEditorAtIndex1"), {
    desc = "Open Editor at Index 1"
})
vim.keymap.set("n", "t2", vscode_action("workbench.action.openEditorAtIndex2"), {
    desc = "Open Editor at Index 2"
})
vim.keymap.set("n", "t3", vscode_action("workbench.action.openEditorAtIndex3"), {
    desc = "Open Editor at Index 3"
})
vim.keymap.set("n", "t4", vscode_action("workbench.action.openEditorAtIndex4"), {
    desc = "Open Editor at Index 4"
})
vim.keymap.set("n", "t5", vscode_action("workbench.action.openEditorAtIndex5"), {
    desc = "Open Editor at Index 5"
})

-- LSP
vim.keymap.set("n", "gr", vscode_action("editor.action.rename"), {
    desc = "LSP: Rename Symbol"
})
vim.keymap.set("n", "gp", vscode_action("editor.action.goToReferences"), {
    desc = "LSP: Go To References"
})

-- Substitution
vim.keymap.set("n", "<C-h>", vscode_action("editor.action.startFindReplaceAction"), {})

-- LSP And Move To New Window
vim.keymap.set("n", "gD", function()
    vscode.action("editor.action.revealDefinitionAside")
end, {
    desc = "LSP: Go To Definition And Move To New Window"
})

vim.keymap.set("n", "<C-w>h", vscode_action("workbench.action.focusLeftGroup"), {})
vim.keymap.set("n", "<C-w><C-h>", vscode_action("workbench.action.focusLeftGroup"), {})
vim.keymap.set("n", "<C-w>l", vscode_action("workbench.action.focusRightGroup"), {})
vim.keymap.set("n", "<C-w><C-l>", vscode_action("workbench.action.focusRightGroup"), {})

-- H and L
vim.keymap.set("n", "H", "^", {})
vim.keymap.set("n", "L", "$", {})
vim.keymap.set("v", "H", "^", {})
vim.keymap.set("v", "L", "$", {})
vim.keymap.set("o", "H", "^", {})
vim.keymap.set("o", "L", "$", {})

-- Go To Line And Function
vim.keymap.set("n", "<leader>j", vscode_action("workbench.action.gotoLine"), {
    desc = "Go To Line"
})
vim.keymap.set("n", "go", vscode_action("workbench.action.gotoSymbol"), {
    desc = "Go To Symbol"
})

-- Bookmark
vim.keymap.set("n", "mm", vscode_action("bookmarks.toggle"), {
    desc = "Toggle bookmarks"
})
vim.keymap.set("n", "mn", vscode_action("bookmarks.jumpToNext"), {
    desc = "Next bookmarks"
})
vim.keymap.set("n", "mp", vscode_action("bookmarks.jumpToPrevious"), {
    desc = "Previous bookmarks"
})
vim.keymap.set("n", "ml", vscode_action("bookmarks.list"), {
    desc = "List bookmarks"
})

-- yank and delete all file
vim.keymap.set("n", "<leader>dd", "ggdG<CR>", {
    desc = "Delete all file"
})
vim.keymap.set("n", "<leader>yy", "ggyG<C-o><UP><CR>", {
    desc = "Yank all file"
})

-- move in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {
    desc = "Move this line down"
})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {
    desc = "Move this line up"
})

-- add blank line
vim.keymap.set("n", "<C-j>", ":set paste<CR>m`o<Esc>``:set nopaste<CR>", {
    desc = "Add blank line below"
})
vim.keymap.set("n", "<C-k>", ":set paste<CR>m`O<Esc>``:set nopaste<CR>", {
    desc = "Add blank line above"
})

-- cmake run and debug
vim.keymap.set("n", "<leader>rt", vscode_action("cmake.selectLaunchTarget"), {
    desc = "CMake: Select Target"
})

vim.keymap.set("n", "<leader>rg", vscode_action("cmake.projectStatus.build"), {
    desc = "CMake: Generate"
})

vim.keymap.set("n", "<leader>rr", vscode_action("cmake.launchTarget"), {
    desc = "CMake: Run Target"
})

vim.keymap.set("n", "<leader>rd", vscode_action("cmake.debugTarget"), {
    desc = "CMake: Debug Target"
})

vim.keymap.set("n", "<leader>da", vscode_action("editor.debug.action.toggleBreakpoint"), {
    desc = "Toggle Breakpoint"
})

-- sidebar
vim.keymap.set("n", "<C-n>", vscode_action("workbench.action.toggleSidebarVisibility"), {
    desc = "Toggle Sidebar"
})

