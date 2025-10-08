vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

vim.g.mapleader = " "
vim.keymap.set('n', '<leader>v', ':e $MYVIMRC<CR>')
vim.keymap.set('n', '<leader>z', ':e ~/.config/zsh/.zshrc<CR>')
vim.keymap.set('n', '<C-f>', '<Cmd>Open .<CR>')
require("krishna.lazy")

-- Run cmd for cpp
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
