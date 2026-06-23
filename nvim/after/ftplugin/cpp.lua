
-- Single line
-- vim.bo.makeprg = "g++-16 -std=c++17 % -o %< && gtimeout 4s ./%< < inputf.in > outputf.in"

vim.keymap.set("n", "<leader>r", function()
  local filepath = vim.fn.expand("%")
  local filename = vim.fn.expand("%:r")

  vim.cmd("update")
  print("Compiling...")

  local cmd = {
    "sh", "-c",
    string.format(
      -- "g++-16 %s -o %s 2>&1 && gtimeout 4s ./%s < inputf.in > outputf.in 2>&1",  -- w/ error redirection
      "g++-16 -std=c++17 %s -o %s && gtimeout 4s ./%s < inputf.in > outputf.in",
      filepath, filename, filename
    )
  }

  vim.system(cmd, {text = true}, function(obj)
    vim.schedule(function()
      vim.cmd("checktime")

      if obj.code ~= 0 then
        -- vim.notify("Execution Failed!", vim.log.levels.WARN)  -- w/ error redirection
        local error_msg = obj.stderr ~= "" and obj.stderr or "Time Limit Exceeded!"
        vim.notify("Execution Failed!\n" .. error_msg, vim.log.levels.WARN)
      else
        vim.notify("Execution Successful!", vim.log.levels.INFO)
      end
    end)
  end)
end, {buffer = true, desc = "RunCmd"})
