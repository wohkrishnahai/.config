-- opts
vim.g.netrw_liststyle = 3
vim.o.termguicolors = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.wrap = false
vim.o.cursorline = true
vim.o.signcolumn = "yes"
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.winborder = "rounded"
vim.o.clipboard = "unnamedplus"

-- keymaps
vim.g.mapleader = " "

-- init
require("krishna.lazy")

-- Run command to compile and run
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.api.nvim_buf_create_user_command(0, "Run", function()
      local filepath = vim.fn.expand("%")    -- current file name
      local filename = vim.fn.expand("%:r")  -- filename without extension

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
