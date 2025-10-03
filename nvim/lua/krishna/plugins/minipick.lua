return {
  "echasnovski/mini.pick",
  config = function()
    require("mini.pick").setup()
    vim.keymap.set('n', '<leader>f', ":Pick files<CR>")
	vim.keymap.set('n', '<leader>g', "<Cmd>Pick grep_live<CR>")
	vim.keymap.set('n', '<leader>r', "<Cmd>Pick buffers<CR>")
    vim.keymap.set('n', '<leader>h', ":Pick help<CR>")
  end
}
