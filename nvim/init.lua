require("krishna.core")
require("krishna.lazy")

--Run command to compile and run
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
