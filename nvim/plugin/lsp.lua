vim.pack.add({ 'https://github.com/neovim/nvim-lspconfig' })

-- Lua LS
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/luv/library",
        },
      },
    },
  },
})
vim.lsp.enable("lua_ls")

-- Rust LS
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      check = {
        command = "clippy",
      }
    }
  },
})
vim.lsp.enable("rust_analyzer")

-- QML LS
vim.lsp.config("qmlls", {
  cmd = {
    "qmlls",
    "-I", "/usr/lib/qt6/qml"
  },
  filetypes = {
    "qml",
  }
})
vim.lsp.enable("qmlls")

-- QML Language Server
vim.lsp.config("qml-language-server", {
  cmd = { "qml-language-server" },
  filetypes = { "qml" },
  root_markers = { { 'qmldir', 'shell.qml' }, '.git' }
})

vim.lsp.enable("qml-language-server")

-- Python LS
vim.lsp.config("pyright", {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
      -- venvPath = ".",
      -- venv = ".venv",
    }
  }
})
vim.lsp.enable("pyright")

-- C++ clangd
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=never",
    "--fallback-style=llvm"
  },
})
vim.lsp.enable("clangd")

-- YAML LS
vim.lsp.config("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ["https://json.schemastore.org/clang-format.json"] = {
          ".clang-format",
          ".clang-format-ignore",
        },
      },
      validate = true,
      completion = true,
      hover = true,
    }
  }
})

vim.lsp.enable("yamlls")

-- tinymist for typst
vim.lsp.config("tinymist", {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable"
  }
})

vim.lsp.enable("tinymist")

-- Autoformatting
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    -- Auto-format ("lint") on save.
    -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
        buffer = args.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
        end,
      })
    end
  end,
})
