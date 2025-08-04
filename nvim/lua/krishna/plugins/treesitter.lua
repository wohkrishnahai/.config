return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        --"html", "css", "javascript", "typescript",
        -- "markdown", "markdown_inline",
        -- "lua", "vimdoc",
        "cpp",
      },
      highlight = { enable = true },
    })
  end,
}
