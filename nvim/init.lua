vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>z', ':e ~/.config/zsh/.zshrc<CR>')
vim.keymap.set('n', '<C-f>', '<Cmd>Open .<CR>')

-- Lazy Setup
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  spec = {
    "nvim-tree/nvim-web-devicons",

	-- Colorscheme
	{ "vague2k/vague.nvim",
	  config = function()
        require("vague").setup({transparent = true})
        vim.cmd("colorscheme vague")
      end,
	},

	-- Oil
	{ "stevearc/oil.nvim",
      config = function()
     	require("oil").setup()
     	vim.keymap.set('n', '<leader>e', "<Cmd>Oil<CR>")
	  end,
	},

	-- Telescope
    { "nvim-telescope/telescope.nvim",
	  dependencies = {"nvim-lua/plenary.nvim"},

      config = function()
        require('telescope').setup({
          defaults = {
            preview = {treesitter = false},
            sorting_strategy = "ascending",
            path_displays = "smart",
			borderchars = {"", "", "", "", "", "", "", ""},
            layout_config = {
			  prompt_position = "top",
              -- height = 100,
              -- width = 400,
              preview_cutoff = 40,
            }
          }
        })
     	local builtin = require('telescope.builtin')
     	vim.keymap.set('n', '<leader>f', builtin.find_files)
     	vim.keymap.set('n', '<leader>g', builtin.live_grep)
     	vim.keymap.set('n', '<leader>b', builtin.buffers)
     	vim.keymap.set('n', '<leader>h', builtin.help_tags)
	  end,
	},

	-- Blink
    { "saghen/blink.cmp", version = "1.*",
	  config = function()
        require("blink.cmp").setup({
          keymap = {
			  preset = 'default',
			  ['<CR>'] = {'accept', 'fallback'},
		  },
          completion = {
      	    documentation = {auto_show = true},
   	      },
	    })
	  end,
	},

	-- Autopair
    { "windwp/nvim-autopairs", event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({check_ts = true})
      end,
    },

	-- Mason
	{ "williamboman/mason.nvim",
	  config = function()
        require("mason").setup()
	  end,
	},

	-- Treesitter
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate",
	  config = function ()
        require("nvim-treesitter.configs").setup({
          auto_install = true,
          highlight = {enable = true},
        })
	  end,
	},

	-- LSP
	{ "neovim/nvim-lspconfig",
	  config = function()

	-- vim.api.nvim_create_autocmd('LspAttach', {
	-- 	group = vim.api.nvim_create_augroup('my.lsp', {}),
	-- 	callback = function(args)
	-- 		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
	-- 		if client:supports_method('textDocument/completion') then
	-- 			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
	-- 			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
	-- 			client.server_capabilities.completionProvider.triggerCharacters = chars
	-- 			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
	-- 		end
	-- 	end,
	-- })
	-- vim.cmd [[set completeopt+=menuone,noselect,popup]]

       vim.diagnostic.config({
         virtual_text = true,
       })

       vim.lsp.enable({
         "lua_ls", "clangd",
         "emmet_language_server", --"cssls", "tailwindcss", "ts_ls" 
       })

       vim.lsp.config("lua_ls", {
         settings = { Lua = {diagnostics = {globals = {"vim"}}}}
       })
	  end,
	},

	-- Luasnip
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp",
      config = function()
        require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})
     	local ls = require("luasnip")
     	ls.config.setup({enable_autosnippets = true})
     	vim.keymap.set("i", "<C-e>", function() ls.expand_or_jump(1) end, {silent = true})
	  end,
    },
  },
})


-- Run Cmd for cpp
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<leader>r", function()
      local filepath = vim.fn.expand("%")
      local filename = vim.fn.expand("%:r")

      vim.cmd("update")
      local cmd = string.format(
        "g++-15 %s -o %s 2>&1 && gtimeout 4s ./%s < inputf.in > outputf.in 2>&1",
        filepath, filename, filename
      )
      local output = vim.fn.system(cmd)
      print(output)
      vim.cmd("checktime")
    end, { buffer = true })
  end,
})
