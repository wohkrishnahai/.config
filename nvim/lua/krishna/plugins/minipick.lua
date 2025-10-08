return {
  "echasnovski/mini.pick",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("mini.pick").setup()
    vim.keymap.set('n', '<leader>f', "<Cmd>Pick files<CR>")
	vim.keymap.set('n', '<leader>g', "<Cmd>Pick grep_live<CR>")
	vim.keymap.set('n', '<leader>b', "<Cmd>Pick buffers<CR>")
    vim.keymap.set('n', '<leader>h', "<Cmd>Pick help<CR>")
  end
}
