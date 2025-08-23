return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",

  config = function()
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/krishna/snippets/" })
    local ls = require("luasnip")
    ls.config.setup({enable_autosnippets = true})

	vim.keymap.set("i", "<C-e>", function() ls.expand_or_jump(1) end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<C-J>", function() ls.jump(1) end, { silent = true })
	vim.keymap.set({ "i", "s" }, "<C-K>", function() ls.jump(-1) end, { silent = true })
  end
}
