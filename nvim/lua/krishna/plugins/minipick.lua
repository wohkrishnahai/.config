return {
  "echasnovski/mini.pick",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    require("mini.pick").setup()

    vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
    vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
  end,
}
