return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },

  config = function()
    require("telescope").setup({
      extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
       },
    })
    require("telescope").load_extension("fzf")

    -- prefix f- for find
    local builtin = require('telescope.builtin')

    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
    vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Find string in cwd" })
    vim.keymap.set('n', "<leader>lt", builtin.treesitter, { desc = "List functions" })
    vim.keymap.set('n', "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set('n', "<leader>fb", "<cmd>Telescope builtin<cr>", { desc = "Builtin Telescope cmds" })

  end,
}
