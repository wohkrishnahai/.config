return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        path_display = { "smart" },

        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = "smart_case",
            },
        },
      },
    })

    telescope.load_extension("fzf")

    local keymap = vim.keymap -- for conciseness

    -- prefix f- for find
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set('n', '<leader>lt', "<cmd>Telescope treesitter", { desc = 'List functions' })
    keymap.set('n', '<leader>fh', "<cmd>Telescope help_tags<cr>", { desc = "Telescope help tags"})

    -- use "telescope builtin" to see all the things (commands) that telescope has
  end,
}
