return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "json", "toml",
        --"html", "css", "javascript",
        --"python", typescript",
        "markdown", "markdown_inline",
        "lua", "vimdoc", --"bash",
        "cpp", --"c",
      },

      indent = { enable = true },

      highlight = {
        enable = true,

        -- Disable treesitter highlighting on large files
        disable = function(_, buf)
             local max_filesize = 100 * 1024 -- 100 KB
             local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    vim.notify(
                      "File larger than 100KB treesitter disabled for performance",
                      vim.log.levels.WARN,
                      { title = "Treesitter" }
                    )
                    return true
                end
        end,
      },

    })
  end,
}
