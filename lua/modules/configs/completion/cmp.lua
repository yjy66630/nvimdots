return function()
	local icons = {
		kind = require("modules.utils.icons").get("kind"),
		type = require("modules.utils.icons").get("type"),
		cmp = require("modules.utils.icons").get("cmp"),
	}
	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	-- 通用智能注释插件
	function smart_comment()

		-- 判断光标是否在当前行的末尾
		function is_cursor_at_end()
			local current_line = vim.fn.getline('.')
			local cursor_col = vim.fn.col('.')
			local line_length = string.len(current_line)

			return cursor_col == line_length
		end
		if not is_cursor_at_end() then
			-- 光标不在当前行的末尾，插入一个换行符
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a<CR>", true, true, true), 'n', true)
			return
		end

		-- 获取当前行文本
		local line = vim.fn.getline(vim.fn.line('.'))

		-- 获取当前编辑文件的后缀名
		local file_extension = vim.fn.expand('%:e')

		-- 获取当前行缩进
		local indent = vim.fn.matchstr(line, '^\\s*')

		-- 判断当前行是否以 '#' 开头
		local is_hash
		if file_extension == 'py' then
			is_hash = vim.fn.match(line, '^\\s*#') > -1
			new_line = is_hash and '# ' or ''
		elseif file_extension == 'cc' or file_extension == 'c' or file_extension == 'h' or file_extension == 'cpp' then
			is_hash = vim.fn.match(line, '^\\s*//') > -1
			new_line = is_hash and '// ' or ''
		end

		-- 插入新行
		vim.fn.append(vim.fn.line('.'), indent .. new_line)

		-- 移动到新行
		vim.api.nvim_feedkeys('jA', 'n', true)
	end

	local border = function(hl)
		return {
			{ "┌", hl },
			{ "─", hl },
			{ "┐", hl },
			{ "│", hl },
			{ "┘", hl },
			{ "─", hl },
			{ "└", hl },
			{ "│", hl },
		}
	end

	local compare = require("cmp.config.compare")
	compare.lsp_scores = function(entry1, entry2)
		local diff
		if entry1.completion_item.score and entry2.completion_item.score then
			diff = (entry2.completion_item.score * entry2.score) - (entry1.completion_item.score * entry1.score)
		else
			diff = entry2.score - entry1.score
		end
		return (diff < 0)
	end

	local use_copilot = require("core.settings").use_copilot
	local comparators = use_copilot == true
			and {
				require("copilot_cmp.comparators").prioritize,
				require("copilot_cmp.comparators").score,
				-- require("cmp_tabnine.compare"),
				compare.offset, -- Items closer to cursor will have lower priority
				compare.exact,
				-- compare.scopes,
				compare.lsp_scores,
				compare.sort_text,
				compare.score,
				compare.recently_used,
				-- compare.locality, -- Items closer to cursor will have higher priority, conflicts with `offset`
				require("cmp-under-comparator").under,
				compare.kind,
				compare.length,
				compare.order,
			}
		or {
			-- require("cmp_tabnine.compare"),
			compare.offset, -- Items closer to cursor will have lower priority
			compare.exact,
			-- compare.scopes,
			compare.lsp_scores,
			compare.sort_text,
			compare.score,
			compare.recently_used,
			-- compare.locality, -- Items closer to cursor will have higher priority, conflicts with `offset`
			require("cmp-under-comparator").under,
			compare.kind,
			compare.length,
			compare.order,
		}

	local cmp = require("cmp")
	require("modules.utils").load_plugin("cmp", {
        enabled = function()
		return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt"
			or require("cmp_dap").is_dap_buffer()
		end,
		preselect = cmp.PreselectMode.Item,
		window = {
			completion = {
				border = border("PmenuBorder"),
				winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,Search:PmenuSel",
				scrollbar = false,
			},
			documentation = {
				border = border("CmpDocBorder"),
				winhighlight = "Normal:CmpDoc",
			},
		},
		sorting = {
			priority_weight = 2,
			comparators = comparators,
		},
		formatting = {
			fields = { "abbr", "kind", "menu" },
			format = function(entry, vim_item)
				local lspkind_icons = vim.tbl_deep_extend("force", icons.kind, icons.type, icons.cmp)
				-- load lspkind icons
				vim_item.kind =
					string.format(" %s  %s", lspkind_icons[vim_item.kind] or icons.cmp.undefined, vim_item.kind or "")

				vim_item.menu = setmetatable({
					cmp_tabnine = "[TN]",
					copilot = "[CPLT]",
					buffer = "[BUF]",
					orgmode = "[ORG]",
					nvim_lsp = "[LSP]",
					nvim_lua = "[LUA]",
					path = "[PATH]",
					tmux = "[TMUX]",
					treesitter = "[TS]",
					latex_symbols = "[LTEX]",
					luasnip = "[SNIP]",
					spell = "[SPELL]",
                    dap = "[DAP]",
				}, {
					__index = function()
						return "[BTN]" -- builtin/unknown source names
					end,
				})[entry.source.name]

				local label = vim_item.abbr
				local truncated_label = vim.fn.strcharpart(label, 0, 80)
				if truncated_label ~= label then
					vim_item.abbr = truncated_label .. "..."
				end

				return vim_item
			end,
		},
		matching = {
			disallow_partial_fuzzy_matching = false,
		},
		performance = {
			async_budget = 1,
			max_view_entries = 120,
		},
		-- You can set mappings if you want
		mapping = cmp.mapping.preset.insert({
-- 			["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
			["<CR>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
				else
					vim.fn.feedkeys(t("<ESC>:lua smart_comment()<CR>"))
				end
				end, { "i" }),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-w>"] = cmp.mapping.close(),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif require("luasnip").expand_or_locally_jumpable() then
					vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"))
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "nvim_lsp", max_item_count = 350 },
			{ name = "nvim_lua" },
			{ name = "luasnip" },
			{ name = "path" },
			-- { name = "treesitter" },
			-- { name = "spell" },
			-- { name = "tmux" },
			-- { name = "orgmode" },
			-- { name = "buffer" },
			{ name = "latex_symbols" },
			-- { name = "copilot" },
    		-- { name = 'omni' },
            -- 以下两行原始配置也是被注释掉的
			-- { name = "codeium" },
			-- { name = "cmp_tabnine" },
		},
		experimental = {
			ghost_text = {
				hl_group = "Whitespace",
			},
		},

	})
end
