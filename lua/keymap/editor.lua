local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_callback = bind.map_callback
local et = bind.escape_termcode

local plug_map = {
	-- Plugin: accelerate-jk
	["n|j"] = map_callback(function()
		return et("<Plug>(accelerated_jk_gj)")
	end):with_expr(),
	["n|k"] = map_callback(function()
		return et("<Plug>(accelerated_jk_gk)")
	end):with_expr(),

	-- Plugin persisted.nvim
	-- 快速保存或进入上一次打开的标签页
	["n|<leader>ss"] = map_cu("SessionSave"):with_noremap():with_silent():with_desc("session: Save"),
	["n|<leader>sl"] = map_cu("SessionLoad"):with_noremap():with_silent():with_desc("session: Load current"),
	["n|<leader>sd"] = map_cu("SessionDelete"):with_noremap():with_silent():with_desc("session: Delete"),

	-- Plugin: clever-f
	["n|;"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-forward)")
	end):with_expr(),
	["n|,"] = map_callback(function()
		return et("<Plug>(clever-f-repeat-back)")
	end):with_expr(),

	-- Plugin: comment.nvim
	-- 快速注释，gc为行注释，gb为块注释
	["n|gcc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_linewise_current)")
				or et("<Plug>(comment_toggle_linewise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for line"),
	["n|gbc"] = map_callback(function()
			return vim.v.count == 0 and et("<Plug>(comment_toggle_blockwise_current)")
				or et("<Plug>(comment_toggle_blockwise_count)")
		end)
		:with_silent()
		:with_noremap()
		:with_expr()
		:with_desc("edit: Toggle comment for block"),
	["n|gc"] = map_cmd("<Plug>(comment_toggle_linewise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with operator"),
	["n|gb"] = map_cmd("<Plug>(comment_toggle_blockwise)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with operator"),
	["x|gc"] = map_cmd("<Plug>(comment_toggle_linewise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for line with selection"),
	["x|gb"] = map_cmd("<Plug>(comment_toggle_blockwise_visual)")
		:with_silent()
		:with_noremap()
		:with_desc("edit: Toggle comment for block with selection"),

	-- Plugin: diffview
	["n|<leader>D"] = map_cr("DiffviewOpen"):with_silent():with_noremap():with_desc("git: Show diff"),
	["n|<leader><leader>D"] = map_cr("DiffviewClose"):with_silent():with_noremap():with_desc("git: Close diff"),

	-- Plugin: vim-easy-align
	-- 快速对齐
	-- 用法：vipgea*=，其中vip选中当前段，*指所有，=指在=周围进行对齐
	
	-- = Around the 1st occurrences
	-- 2= Around the 2nd occurrences
	-- *= Around all occurrences
	-- **= Left/Right alternating alignment around all occurrences
	-- <Enter> Switching between left/right/center alignment modes
	["nx|gea"] = map_cr("EasyAlign"):with_desc("edit: Align with delimiter"),

	-- Plugin: hop
	-- 相当于easy-motion
	["nv|<leader>w"] = map_cmd("<Cmd>HopWordMW<CR>"):with_noremap():with_desc("jump: Goto word"),
	["nv|<leader>j"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
	["nv|<leader>k"] = map_cmd("<Cmd>HopLineMW<CR>"):with_noremap():with_desc("jump: Goto line"),
	-- 输入一个字母
	["nv|<leader>c1"] = map_cmd("<Cmd>HopChar1MW<CR>"):with_noremap():with_desc("jump: Goto one char"),
	-- 输入两个字母
	["nv|<leader>c2"] = map_cmd("<Cmd>HopChar2MW<CR>"):with_noremap():with_desc("jump: Goto two chars"),

	-- Plugin: treehopper
	-- 在代码树中跳转
	["o|m"] = map_cu("lua require('tsht').nodes()"):with_silent():with_desc("jump: Operate across syntax tree"),

	-- Plugin: tabout
	-- 跳转到括号外部
	["i|<A-l>"] = map_cmd("<Plug>(TaboutMulti)"):with_silent():with_noremap():with_desc("edit: Goto end of pair"),
	["i|<A-h>"] = map_cmd("<Plug>(TaboutBackMulti)"):with_silent():with_noremap():with_desc("edit: Goto begin of pair"),

	-- Plugin suda.vim
	["n|<A-s>"] = map_cu("SudaWrite"):with_silent():with_noremap():with_desc("editn: Save file using sudo"),


	-- 取消部分快捷键
	["n|Y"] = "",
	["n|D"] = "",

	["n|H"] = map_cmd("^"):with_desc("edit: move the left of line"),
	["n|L"] = map_cmd("$"):with_desc("edit: move the right of line"),
	["v|H"] = map_cmd("^"):with_desc("edit: move the left of line"),
	["v|L"] = map_cmd("$"):with_desc("edit: move the right of line"),
	["o|H"] = map_cmd("^"):with_desc("edit: move the left of line"),
	["o|L"] = map_cmd("$"):with_desc("edit: move the right of line"),

	-- tab并取消原本的cleverf映射
	["n|f"] = map_cmd("<Plug>(clever-f-f)"):with_desc("clever_f: f"),
	["x|f"] = map_cmd("<Plug>(clever-f-f)"):with_desc("clever_f: f"),
	["o|f"] = map_cmd("<Plug>(clever-f-f)"):with_desc("clever_f: f"),
	["n|F"] = map_cmd("<Plug>(clever-f-F)"):with_desc("clever_f: F"),
	["x|F"] = map_cmd("<Plug>(clever-f-F)"):with_desc("clever_f: F"),
	["o|F"] = map_cmd("<Plug>(clever-f-F)"):with_desc("clever_f: F"),
	
	["n|t"] = "",
	["n|tk"] = "",
	["n|tj"] = "",
	["n|t1"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent():with_desc("tab: go to visual tab 1"),
	["n|t2"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent():with_desc("tab: go to visual tab 2"),
	["n|t3"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent():with_desc("tab: go to visual tab 3"),
	["n|t4"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent():with_desc("tab: go to visual tab 4"),
	["n|t5"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent():with_desc("tab: go to visual tab 5"),
	["n|t6"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent():with_desc("tab: go to visual tab 6"),
	["n|t7"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent():with_desc("tab: go to visual tab 7"),
	["n|t8"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent():with_desc("tab: go to visual tab 8"),
	["n|t9"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent():with_desc("tab: go to visual tab 9"),
	["n|t0"] = map_cr("BufferLineGoToBuffer -1"):with_noremap():with_silent():with_desc("tab: go to visual tab last"),
	
	["n|tt"] = map_cr("BufferLineTogglePin"):with_noremap():with_silent():with_desc("tab: pin this tab"),
	["n|tn"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent():with_desc("tab: Move to next tab"),
	["n|tp"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent():with_desc("tab: Move to previous tab"),
	["n|tc"] = map_cr("BufferLineCloseOthers"):with_noremap():with_silent():with_desc("tab: Only keep current tab"),
	-- Plugin: nvim-bufdel
	-- 关闭当前buffer
	["n|tq"] = map_cr("BufDel"):with_noremap():with_silent():with_desc("buffer: Close current"),

	["n|<Leader>yy"] = map_cr("%y<CR>"):with_noremap():with_silent():with_desc("yank the whole file"),
	["n|<Leader>dd"] = map_cr("%d<CR>"):with_noremap():with_silent():with_desc("delete the whole file"),

	["n|<Leader>cx"] = map_cmd("<Plug>(Exchange)"):with_noremap():with_silent():with_desc("exchange: exchange two yanks"),
	["x|X"] = map_cmd("<Plug>(Exchange)"):with_noremap():with_silent():with_desc("exchange: exchange two yanks"),
	["n|<Leader>cxc"] = map_cmd("<Plug>(ExchangeClear)"):with_noremap():with_silent():with_desc("exchange: clear exchanges"),
	["n|<Leader>cxx"] = map_cmd("<Plug>(ExchangeLine)"):with_noremap():with_silent():with_desc("exchange: exchange two lines"),
    
    ["n|w"] = map_cr("lua require('spider').motion('w')"):with_noremap():with_silent():with_desc("Spider-w"),
    ["o|w"] = map_cr("lua require('spider').motion('w')"):with_noremap():with_silent():with_desc("Spider-w"),
    ["x|w"] = map_cr("lua require('spider').motion('w')"):with_noremap():with_silent():with_desc("Spider-w"),
    ["n|e"] = map_cr("lua require('spider').motion('e')"):with_noremap():with_silent():with_desc("Spider-e"),
    ["o|e"] = map_cr("lua require('spider').motion('e')"):with_noremap():with_silent():with_desc("Spider-e"),
    ["x|e"] = map_cr("lua require('spider').motion('e')"):with_noremap():with_silent():with_desc("Spider-e"),
    ["n|b"] = map_cr("lua require('spider').motion('b')"):with_noremap():with_silent():with_desc("Spider-b"),
    ["o|b"] = map_cr("lua require('spider').motion('b')"):with_noremap():with_silent():with_desc("Spider-b"),
    ["x|b"] = map_cr("lua require('spider').motion('b')"):with_noremap():with_silent():with_desc("Spider-b"),

    ["n|gg"] = map_cr("TSCppDefineClassFunc"):with_noremap():with_silent():with_desc("generate: generate implementation according decleration"),
    ["x|gg"] = map_cr("TSCppDefineClassFunc"):with_noremap():with_silent():with_desc("generate: generate implementation according decleration"),
    

}

bind.nvim_load_mapping(plug_map)
