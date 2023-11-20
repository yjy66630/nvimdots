if not vim.g.vscode then
	-- 禁用clever-f默认设置
	vim.g.clever_f_not_overwrites_standard_mappings = 1
	require("core")
end
