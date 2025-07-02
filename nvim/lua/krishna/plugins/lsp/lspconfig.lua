return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    --local lspconfig = require("lspconfig")
    --local mason_lspconfig = require("mason-lspconfig")
    --local cmp_nvim_lsp = require("cmp_nvim_lsp")

    local keymap = vim.keymap

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        opts.desc = "Show LSP definitions"
        keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

        opts.desc = "Show documentation for what is under cursor"
        keymap.set("n", "K", vim.lsp.buf.hover, opts)

        opts.desc = "Format the open file"
        keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)

        opts.desc = "See available code actions"
        keymap.set({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, opts) -- applies to selection in visual mode

        opts.desc = "Smart rename"
        keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)

        opts.desc = "Show line diagnostics"
        keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

        opts.desc = "Go to previous diagnostic"
        keymap.set("n", "<leader>lp", vim.diagnostic.goto_prev, opts)

        opts.desc = "Go to next diagnostic"
        keymap.set("n", "<leader>ln", vim.diagnostic.goto_next, opts)

        -- use :LspStop & :LspRestart in default manner only
      end
    })


    -- diagnostic signs to use
    local diagnostic_signs = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.INFO] = " ",
            [vim.diagnostic.severity.HINT] = "󰌵", -- 
    }


    -- Change the Diagnostic symbols in the sign column (gutter)
    vim.diagnostic.config({
        signs = { text = diagnostic_signs, },
        -- virtual_lines = { current_line = true, },
     })

    --lus_ls config
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "bit", "it", "describe" }
                }
            }
        }
    })

    vim.lsp.config("clangd", {
        cmd = {
            "clangd",
            -- "--fallback-style=webkit"
            "--fallback-style={BasedOnStyle: llvm, ShiftWidth: 4, IndentWidth: 4, TabWidth: 4, UseTab: Never}"
         }
    })

  end,
}
