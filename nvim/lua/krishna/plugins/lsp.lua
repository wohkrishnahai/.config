return {
  "neovim/nvim-lspconfig",

  dependencies = {
    -- mason
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- nvim-cmp
    "hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    -- mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "clangd", },
    })

    -- nvim-cmp
    local cmp = require("cmp")
    cmp.setup({
       completion = {
         completeopt = "menu, menuone, noselect",
       },

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp",
            entry_filter = function(entry) -- reduce noice
                return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
        },
      })
    })


    -- lspconfig
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)

		-- native lsp auto completion
		-- local client = vim.lsp.get_client_by_id(ev.data.client_id)
		-- if client:supports_method('textDocument/completion') then
		-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		-- end

        local opts = { buffer = ev.buf, silent = true }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
        vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)
        -- use default :LspStop & :LspRestart
      end
    })
	-- vim.cmd("set completeopt+=noselect")

    -- vim.diagnostic.config({
    --     virtual_text = true,
    --  })


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
