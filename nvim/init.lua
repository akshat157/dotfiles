-- require("config.lazy")

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

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

vim.keymap.set("n", "<leader>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 8)
end)

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
-- Line numbering
vim.opt.number = true         -- absolute line numbers
vim.opt.relativenumber = true -- relative line numbers

-- Tabs and indentation
vim.opt.tabstop = 4        -- how many spaces does a tab count for
vim.opt.shiftwidth = 4     -- size of an indent
vim.opt.expandtab = true   -- use spaces instead of tabs
vim.opt.smartindent = true -- autoindent new lines

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

-- Folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldcolumn = "0"
-- vim.opt.fillchars = {
--   foldopen = "", -- arrow down
--   foldclose = "", -- arrow right
--   fold = " ",
--   foldsep = " ",
-- }
vim.opt.foldenable = true
