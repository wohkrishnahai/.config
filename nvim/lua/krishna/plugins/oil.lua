return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = {
        view_options = { show_hidden = true, }
    },

    config = function()
        require("oil").setup({})
        vim.keymap.set({ "n", "x" }, "<leader>e", function() require("oil").open() end, { silent = true })
    end
}
