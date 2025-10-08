-- File: lua/pckill3r/lazy/lsp.lua
return {
  "neovim/nvim-lspconfig", -- still useful for server presets ("data")
  dependencies = {
    "stevearc/conform.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    -- LSP progress/status UI
    require("fidget").setup({})
    require("mason").setup()

    -- Install/ensure servers
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "gopls",
        "ts_ls",
        "eslint",
        "zls",
        "angularls",
      },
    })

    -- Capabilities for LSP completion
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_lsp.default_capabilities()

    -- nvim-cmp completion setup
    cmp.setup({
      snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = {
        { name = "copilot", group_index = 2 },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
      },
    })

    -- Configure diagnostics floating popup
    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- Helper: root_dir via vim.fs (avoids requiring lspconfig.framework)
    local function root_dir_with(markers)
      return function(fname)
        local start = vim.fs.dirname(fname)
        local found = vim.fs.find(markers, { path = start, upward = true })[1]
        return found and vim.fs.dirname(found) or nil
      end
    end

    ---------------------------------------------------------------------------
    -- New core API: define defaults with vim.lsp.config(), then enable them.
    ---------------------------------------------------------------------------

    -- Lua
    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "Lua 5.1" },
          diagnostics = {
            globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
          },
        },
      },
    })

    -- Rust
    vim.lsp.config("rust_analyzer", {
      capabilities = capabilities,
    })

    -- Go
    vim.lsp.config("gopls", {
      capabilities = capabilities,
    })

    -- TypeScript / TSX (React) — using ts_ls
    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      -- settings = { typescript = { format = { semicolons = "insert" } } },
    })

    -- ESLint
    vim.lsp.config("eslint", {
      capabilities = capabilities,
    })

    -- Zig
    vim.lsp.config("zls", {
      capabilities = capabilities,
      root_dir = root_dir_with({ ".git", "build.zig", "zls.json" }),
    })

    -- Angular — restrict to Angular workspaces only
    vim.lsp.config("angularls", {
      capabilities = capabilities,
      filetypes = { "typescript", "html" }, -- do NOT include 'typescriptreact'
      root_dir = root_dir_with({ "angular.json", "project.json", "nx.json" }),
    })

    -- Finally, enable the servers you use.
    for _, name in ipairs({
      "lua_ls",
      "rust_analyzer",
      "gopls",
      "ts_ls",
      "eslint",
      "zls",
      "angularls",
    }) do
      vim.lsp.enable(name)
    end
  end,
}
