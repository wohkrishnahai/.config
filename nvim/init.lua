require("krishna.core")
require("krishna.lazy")

-- for cpp
-- custom Run command to take input from inputf.in file 
-- and get output and errors in directly in outputf.in file
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    -- for :Run command to only work in current cpp buffer
    vim.api.nvim_buf_create_user_command(0, "Run", function()
      local filepath = vim.fn.expand("%")    -- current file name
      local filename = vim.fn.expand("%:r")  -- filename without extension

      local cmd = string.format(
        "g++-15 %s -o %s 2>&1 && gtimeout 4s ./%s <inputf.in >outputf.in 2>&1",
        filepath, filename, filename
      )

      vim.fn.system(cmd)
      vim.cmd("checktime") -- reload output file if changed

    end, {}
    )
  end,
})
