require("krishna.core")
require("krishna.lazy")

--for compiling and running cpp files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.opt_local.makeprg = "g++-15 % -o %< && gtimeout 4s ./%< <inputf.in >outputf.in"
  end,
},

--assigning :Run to :silent make to get output directly in outputf.in only
vim.api.nvim_create_user_command("Run", "silent make", {})
)
