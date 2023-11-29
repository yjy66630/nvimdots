return function()
    -- 光标颜色
    vim.g.edge_cursor = 'purple'
    -- 光标闪烁
    vim.opt.guicursor = 'n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,a:blinkon50'
    -- 使用/命令搜索得到的匹配项
    vim.g.edge_menu_selection_background = 'purple'
--     vim.cmd [[hi CursorLine guibg=#808080]]
end
