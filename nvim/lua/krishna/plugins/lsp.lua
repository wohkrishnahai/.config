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

	-- vim.diagnostic.config({
	--   virtual_text = true,
	-- })

	vim.lsp.enable({ "lua_ls", "clangd", "emmet_language_server" })

    vim.lsp.config("lua_ls", {
      settings = {
	    Lua = { diagnostics = { globals = { "vim" } } }
      }
    })

	vim.lsp.config("emmet_language_server", {
	  filetypes = {
		"html", "css",
	  },
	  init_options = {
		showAbbreviationSuggestions = true,
		showExpandedAbbreviation = "always",
		showSuggestionsAsSnippets = true,
		html = {
		  output = {
			selfClosingStyle = "html", -- or "xml"
		  },
		},
	  },
	})
  end
}
