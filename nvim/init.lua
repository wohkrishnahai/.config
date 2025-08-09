vim.g.netrw_liststyle = 3
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.g.mapleader = " "

require("krishna.lazy")

-- Run - compile and run
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.api.nvim_buf_create_user_command(0, "Run", function()
      local filepath = vim.fn.expand("%")    -- file name
      local filename = vim.fn.expand("%:r")  -- file name w/o extension

      local cmd = string.format(
        "g++-15 %s -o %s 2>&1 && gtimeout 4s ./%s <inputf.in >outputf.in 2>&1",
        filepath, filename, filename
      )

      vim.fn.system(cmd)
      vim.cmd("checktime")

    end, {}
    )
  end,
})
