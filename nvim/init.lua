vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.g.mapleader = " "
vim.keymap.set("n", "<C-f>", "<Cmd>Open .<CR>")
vim.keymap.set("n", "<leader>v", "<Cmd>e $MYVIMRC<CR>")
vim.keymap.set("n", "<leader>z", "<Cmd>e ~/.config/zsh/.zshrc<CR>")
vim.keymap.set("n", "<ESC>", "<Cmd>nohlsearch<CR>", {noremap = true, silent = true})
-- vim.keymap.set("n", "<leader>r", "<Cmd>make<CR>")

-- Term keymaps
vim.keymap.set({"n", "t"}, "<leader>st", "<Cmd>botright 5split<CR> <Cmd>term<CR>i", {desc = "Small Terminal at bottom"});
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", {desc = "Enter Normal mode in terminal"})

-- Tab Switching
for i = 1, 8 do
	vim.keymap.set({"n","t"}, "<Leader>" .. i, "<Cmd>tabnext " .. i .. "<CR>")
end

-- Plugins
vim.pack.add({
  {src = "https://github.com/vague2k/vague.nvim"},
	{src = "https://github.com/stevearc/oil.nvim"},
	{src = "https://github.com/nvim-tree/nvim-web-devicons"},
	{src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main"},
	{src = "https://github.com/neovim/nvim-lspconfig"},
	{src = "https://github.com/mason-org/mason.nvim"},
	{src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8"},
	{src = "https://github.com/nvim-lua/plenary.nvim"},
	{src = "https://github.com/L3MON4D3/LuaSnip"},
	{src = "https://github.com/chomosuke/typst-preview.nvim"},
	{src = "https://github.com/windwp/nvim-autopairs"},
})

require("vague").setup({transparent = true})
vim.cmd.colorscheme("vague")

require("oil").setup()
vim.keymap.set('n', '<leader>e', "<Cmd>Oil<CR>")

require("telescope").setup({
  defaults = {
    preview = {treesitter = false},
    path_displays = "smart",
    borderchars = {"", "", "", "", "", "", "", ""},
    layout_config = { preview_cutoff = 40, },
  },
})
local builtin = require('telescope.builtin')
vim.keymap.set("n", "<leader>f", builtin.find_files)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>sb", builtin.buffers)
vim.keymap.set("n", "<leader>sd", builtin.diagnostics)
vim.keymap.set("n", "<leader>gs", builtin.git_status)
vim.keymap.set("n", "<leader>sh", builtin.help_tags)
vim.keymap.set("n", "<leader>sk", builtin.keymaps)
vim.keymap.set("n", "<leader>st", builtin.builtin, {desc = "Builtin Telescope Commands"})

require("nvim-autopairs").setup({check_ts = true})

require("typst-preview").setup()
vim.keymap.set("n", "<leader>p", "<Cmd>TypstPreview<CR>")


-- LSP
require("mason").setup()

require("nvim-treesitter").setup()
-- Auto-install Parsers
-- require("nvim-treesitter").install({
--   'lua', 'markdown', 'typst', 'c', 'cpp', -- 'python',
--   'javascript', -- 'tsx', 'typescript', 
-- })

-- Highlighting
vim.api.nvim_create_autocmd('FileType', {
	pattern = {
    'lua', 'markdown', 'typst', 'cpp', -- 'c', 'python',
    'javascript', -- 'react', 'typescriptreact', 'typescript'
  },
	callback = function()
    vim.treesitter.start()
  end,
})

vim.diagnostic.config({virtual_text = true,})

vim.lsp.enable({
  "lua_ls", "clangd", "tinymist",
  "emmet_ls", "emmet_language_server", "cssls", -- "tailwindcss", "ts_ls",
})


vim.lsp.config("lua_ls", {
  settings = {Lua = {diagnostics = {globals = {"vim"}}}}
})

vim.lsp.config("tinymist", {
  cmd = {"tinymist"},
  filetypes = {"typst"},
  settings = {formatterMode = "typstyle"},
})

-- Native Autocompletion
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			-- client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
		end
	end,
})
vim.opt.completeopt = {"menu", "menuone", "noinsert", "popup"}


-- Luasnip
local ls = require("luasnip")
ls.setup({enable_autosnippets = true})
require("luasnip.loaders.from_lua").load({paths = "~/.config/nvim/snippets/"})
vim.keymap.set("i", "<C-e>", function() ls.expand_or_jump(1) end, {silent = true})

-- Unused Plugins Mgmt
local function pack_clean()
	local active_plugins = {}
	local unused_plugins = {}

	for _, plugin in ipairs(vim.pack.get()) do
		active_plugins[plugin.spec.name] = plugin.active
	end

	for _, plugin in ipairs(vim.pack.get()) do
		if not active_plugins[plugin.spec.name] then
			table.insert(unused_plugins, plugin.spec.name)
		end
	end

	if #unused_plugins == 0 then
		print("No unused plugins.")
		return
	end

	local choice = vim.fn.confirm("Remove unused plugins?", "&Yes\n&No", 2)
	if choice == 1 then
		vim.pack.del(unused_plugins)
	end
end

vim.keymap.set("n", "<leader>pc", pack_clean)


-- RunCmd for cpp
vim.api.nvim_create_autocmd("FileType", {
  pattern = "cpp",
  callback = function()
    vim.keymap.set("n", "<leader>r", function()
      local filepath = vim.fn.expand("%")
      local filename = vim.fn.expand("%:r")

      vim.cmd("update")
      print("Compiling...")

      local cmd = {
        "sh", "-c",
        string.format(
          -- "g++-15 %s -o %s 2>&1 && gtimeout 4s ./%s < inputf.in > outputf.in 2>&1",  -- w/ error redirection
          "g++-15 -std=c++17 %s -o %s && gtimeout 4s ./%s < inputf.in > outputf.in",
          filepath, filename, filename
        )
      }

      vim.system(cmd, {text = true}, function(obj)
        vim.schedule(function()
          vim.cmd("checktime")

          if obj.code ~= 0 then
            -- vim.notify("Execution Failed!", vim.log.levels.WARN)  -- w/ error redirection
            local error_msg = obj.stderr ~= "" and obj.stderr or "Check Compiler Message!"
            vim.notify("Execution Failed!\n" .. error_msg, vim.log.levels.WARN)
          else
            vim.notify("Execution Successful!", vim.log.levels.INFO)
          end
        end)
      end)
    end, {buffer = true, desc = "RunCmd"})
  end,
})
