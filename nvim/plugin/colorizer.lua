vim.pack.add({ 'https://github.com/catgoose/nvim-colorizer.lua' })

vim.api.nvim_create_autocmd("BufReadPre", {
  once = true,
  callback = function()
    require("colorizer").setup({
      filetypes = {
        "css",
        "scss",
        "html",
        "lua",
        "tsx",
        "jsx",
      }
    })
  end
})
