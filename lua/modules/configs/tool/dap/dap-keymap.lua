local M = {}

local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

local did_load_debug_mappings = false
local debug_keymap = {
	["nv|K"] = map_cmd("<Cmd>lua require('dapui').eval()<CR>")
		:with_noremap()
		:with_nowait()
		:with_desc("Evaluate expression under cursor"),
	["nv|<Leader>dh"] = map_cmd("<Cmd>lua require('dap.ui.widgets').hover()<CR>")
		:with_noremap()
		:with_nowait()
		:with_desc("Evaluate expression under cursor in hover windows"),
	["nv|<Leader>dp"] = map_cmd("<Cmd>lua require('dap.ui.widgets').preview()<CR>")
		:with_noremap()
		:with_nowait()
		:with_desc("Evaluate expression under cursor in preview windows"),
	["nv|<Leader>df"] = map_cmd("<Cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').frames)<CR>")
		:with_noremap()
		:with_nowait()
		:with_desc("alter dap stack in hover windows"),
	["nv|<Leader>ds"] = map_cmd("<Cmd>lua require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes)<CR>")
		:with_noremap()
		:with_nowait()
		:with_desc("Evaluate all local variables in hover windows"),
}

function M.load_extras()
	if not did_load_debug_mappings then
		require("modules.utils.keymap").amend("Debugging", "_debugging", debug_keymap)
		did_load_debug_mappings = true
	end
end

return M
