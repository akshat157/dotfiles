require("config.lazy")

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd('TermOpen', {
	desc = 'Disable line numbers inside terminal',
	group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
	callback = function()
		vim.opt.number = false
        vim.opt.relativenumber = false
	end,
})

-- Line numbering
vim.opt.number = true           -- absolute line numbers
vim.opt.relativenumber = true	-- relative line numbers

-- Tabs and indentation
vim.opt.tabstop = 4		-- how many spaces does aa tab count for
vim.opt.shiftwidth = 4		-- size of an indent
vim.opt.expandtab = true	-- use spaces instead of tabs
vim.opt.smartindent = true	-- autoindent new lines

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- UI
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- Scrolling
vim.opt.scrolloff = 8

-- Mouse
vim.opt.mouse = "a"

-- System clipboard
vim.opt.clipboard = "unnamedplus"

-- Show invisible characters
vim.opt.list = true

vim.opt.listchars = {
  tab = "▸ ",
  trail = "-",
}

