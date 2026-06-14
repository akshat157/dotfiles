vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
  'https://github.com/nvim-telescope/telescope.nvim'
})

vim.fn.system("make -C " .. vim.fn.stdpath("data") .. "/site/pack/core/opt/telescope-fzf-native.nvim")


require('telescope').setup {
  pickers = {
    find_files = {
      theme = "ivy"
    }
  },
  extensions = {
    fzf = {}
  }
}

require('telescope').load_extension('fzf')

vim.keymap.set("n", "<space>fd", require('telescope.builtin').find_files)

vim.keymap.set("n", "<space>en", function()
  require('telescope.builtin').find_files {
    cwd = vim.fn.stdpath("config")
  }
end)

vim.keymap.set("n", "<space>ep", function()
  require('telescope.builtin').find_files {
    cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
  }
end)
