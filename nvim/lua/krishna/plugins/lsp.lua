return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim" },

  config = function()
    require("mason").setup()

	vim.api.nvim_create_autocmd("LspAttach", {
	  callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf, silent = true }
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
	  end
	})
	vim.opt.completeopt = {"menu", "menuone"}

	-- native LSP auto completion
	-- vim.api.nvim_create_autocmd('LspAttach', {
	-- 	group = vim.api.nvim_create_augroup('my.lsp', {}),
	-- 	callback = function(args)
	-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	-- 		if client:supports_method('textDocument/completion') then
	-- 			-- Optional: trigger autocompletion on EVERY keypress. (may be slow)
	-- 			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
	-- 			client.server_capabilities.completionProvider.triggerCharacters = chars
	-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
	-- 		end
	-- 	end,
	-- })
	-- vim.opt.completeopt:append {"menu, menuone, popup"}

	vim.diagnostic.config({
	  virtual_text = true,
	})

	vim.lsp.enable({ "lua_ls", "clangd", "emmet_language_server" })

    vim.lsp.config("lua_ls", {
      settings = {
	    Lua = { diagnostics = { globals = { "vim" } } }
      }
    })
  end
}
