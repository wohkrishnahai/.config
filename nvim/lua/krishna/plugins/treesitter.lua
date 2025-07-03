return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",

  config = function()
    local treesitter = require("nvim-treesitter.configs")

    treesitter.setup({
      highlight = { enable = true },
      indent = { enable = true },

      ensure_installed = {
        "json", "toml",
        --"html", "css", "javascript",
        --"python", typescript",
        "markdown", "markdown_inline",
        "lua", "vimdoc", --"bash",
        "cpp", --"c",
      },
    })
  end,
}
