return {
  "neovim/nvim-lspconfig",
  dependencies = {
  	"vague2k/vague.nvim",
 	"stevearc/oil.nvim",
	"nvim-tree/nvim-web-devicons",
	{'nvim-telescope/telescope.nvim', dependencies = {'nvim-lua/plenary.nvim'}},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"saghen/blink.cmp", version = "1.*" },
	{"windwp/nvim-autopairs", event = "InsertEnter"},
    {"L3MON4D3/LuaSnip", build = "make install_jsregexp"},
    "williamboman/mason.nvim",
  },

  config = function()
	-- Colorscheme
    require("vague").setup({ transparent = true })
    vim.cmd("colorscheme vague")
    vim.cmd(":hi statusline guibg=NONE")
	-- vim.cmd("hi TabLineFill guibg=NONE")

	-- Oil
    require("oil").setup()
    vim.keymap.set('n', '<leader>e', "<Cmd>Oil<CR>")


	-- Telescope
    require('telescope').setup({
      defaults = {
	    preview = {treesitter = false},
	    sorting_strategy = "ascending",
	    path_displays = "smart",
	    --    layout_config = {
	    --   height = 100,
	    --   width = 400,
	    --   preview_cutoff = 40,
	    -- }
	  }
	})
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files)
    vim.keymap.set('n', '<leader>g', builtin.live_grep)
    vim.keymap.set('n', '<leader>b', builtin.buffers)
    vim.keymap.set('n', '<leader>h', builtin.help_tags)

	-- Blink
	require("blink.cmp").setup({
      keymap = {preset = 'default'},
      completion = {
		documentation = {auto_show = true},
  	  },
	})
    require("nvim-autopairs").setup({ check_ts = true })


	-- LSP
    require("mason").setup()

	-- vim.api.nvim_create_autocmd('LspAttach', {
	--   group = vim.api.nvim_create_augroup('my.lsp', {}),
	--   callback = function(args)
	-- 	local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	-- 	if client:supports_method('textDocument/completion') then
	-- 	  --Trigger autocompletion on EVERY keypress
	-- 	  local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
	-- 		client.server_capabilities.completionProvider.triggerCharacters = chars
	-- 		vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
	-- 	  end
	-- 	end,
	-- })
	-- vim.cmd[[set completeopt+=menuone,noselect,popup]]

	vim.diagnostic.config({
	  virtual_text = true,
	})

	vim.lsp.enable({
	  "lua_ls", "clangd",
	  "emmet_language_server", --"cssls", "tailwindcss", "ts_ls" 
	})

    vim.lsp.config("lua_ls", {
      settings = {
	    Lua = {diagnostics = {globals = {"vim"}}}
      }
    })

	-- Luasnip
    require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/lua/krishna/snippets/"})
    local ls = require("luasnip")
    ls.config.setup({enable_autosnippets = true})
	vim.keymap.set("i", "<C-e>", function() ls.expand_or_jump(1) end, {silent = true})

	-- Treesitter
    require("nvim-treesitter.configs").setup({
	  auto_install = true,
      highlight = {enable = true},
    })

  end
}
