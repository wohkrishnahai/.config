return {
    --use "gc" followed by motion to comment/uncomment a block of code
    --use "gcc" to comment/uncomment current line of code
    "numToStr/Comment.nvim",
    event = {"BufReadPre", "BufNewFile"},

    config = function()
        require("Comment").setup()
    end
}
