-- NOTE: Requires Rust to be installed!
vim.pack.add({
  'https://github.com/rafamadriz/friendly-snippets',
  'https://github.com/saghen/blink.lib',
  'https://github.com/saghen/blink.cmp'
})

require("blink.cmp").setup({
  keymap = { preset = 'default' },
  sources = {
    default = { 'lsp', 'buffer', 'path', 'snippets' },
  },
  appearance = { nerd_font_variant = 'mono' },
  completion = { documentation = { auto_show = true } },
  fuzzy = { implementation = "lua" }
})

-- local blink_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/blink.cmp"
--
-- if vim.fn.isdirectory(blink_path) == 1 then
--   vim.fn.system({ "cargo", "build", "--release", "--manifest-path", blink_path .. "/Cargo.toml" })
-- end
