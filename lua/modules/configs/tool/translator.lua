return function()
-- vim.g.translator_default_engines = {'haici'}
vim.g.translator_proxy_url = 'socks5://127.0.0.1:7890'
  require("modules.utils").load_plugin("translator", {})
end
