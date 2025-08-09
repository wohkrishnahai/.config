return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim" },

  config = function()
    require("mason").setup()

	-- omnifucn completion - <c-x><c-o>
	vim.api.nvim_create_autocmd("LspAttach", {
	  callback = function(ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

		local opts = { buffer = ev.buf, silent = true }
		vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
	  end,
	})
	vim.opt.completeopt = { "menu", "menuone", "noselect" }

	-- vim.diagnostic.config({
	--   virtual_text = true,
	-- })

	vim.lsp.enable({ "lua_ls", "clangd" })
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = {"vim"}
                }
            }
        }
    })
  end,
}
