return {
  "neovim/nvim-lspconfig",

  dependencies = {
    -- lsp
    "hrsh7th/cmp-nvim-lsp",
    -- mason
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- nvim-cmp
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
  },

  config = function()
    -- mason
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { -- lang servers
        "lua_ls",
        "clangd",
      },
    })


    -- nvim-cmp
    local cmp = require("cmp")
    vim.api.nvim_set_hl(0, "CmpNormal", {})

    cmp.setup({
      completeopt = "menu, menuone, noselect",

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),

      window = {  -- rounded borders
        completion = {
            scrollbar = false,
            border = "rounded",
            winhighlight = "Normal:CmpNormal",
        },
        documentation = {
            scrollbar = false,
            border = "rounded",
            winhighlight = "Normal:CmpNormal",
        }
      },

      sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp",
            entry_filter = function(entry, ctx) -- reduce noice
                return cmp.lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            end,
        },
        -- {name = "buffer" },
        -- {name = "path" },
      })
    })


    -- lspconfig
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        opts.desc = "Show LSP definitions"
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show documentation for what is under cursor"
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Format the open file"
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

        opts.desc = "See available code actions"
        vim.keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- applies to selection in visual mode

        opts.desc = "Smart rename"
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostics"
        vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        vim.keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        vim.keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)

        -- use default :LspStop & :LspRestart
      end
    })


    local diagnostic_signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵",
    }

    vim.diagnostic.config({
        signs = { text = diagnostic_signs },
        float = { border = "rounded" },
        -- virtual_text = true,
     })


    --custom lang server configs
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "bit", "it", "describe" }
                }
            }
        }
    })

  end,
}
