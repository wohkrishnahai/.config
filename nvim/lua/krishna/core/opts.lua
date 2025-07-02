vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.wrap = false
opt.cursorline = true -- enables highlighting of current line


--tabs & indentation 
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true


--search settings
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false


-- turn on termgui colours for colorscheme to work
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"

-- file and backup behaviour
opt.swapfile = false  -- disables creation of .swp files (used for crash recovery)
opt.backup = false  -- disables creation of backup files before overwriting

-- backspace
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

--split windows 
opt.splitright = true -- split vertical window to right
opt.splitbelow = true -- split horizontal window to bottom


