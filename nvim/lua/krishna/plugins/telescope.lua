return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    'nvim-lua/plenary.nvim',
  },

  opts = {
    defaults = {
	  preview = { treesitter = false },
	  sorting_strategy = "ascending",
  	  borders = true,
      -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	  path_displays = "smart",
      layout_config = {
	    height = 100,
	    width = 400,
	    prompt_position = "top",
	    preview_cutoff = 40,
	  }
    },
  },

  config = function()
    require('telescope').setup()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Help Tags' })
  end
}
