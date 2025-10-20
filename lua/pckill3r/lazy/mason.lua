return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "tailwindcss",
        "typescript-language-server",
        "html",
        "cssls"
      },
      automatic_installation = true,
    })

    -- Remove this problematic section since you're already configuring LSP in lsp.lua
    -- require("mason-lspconfig").setup_handlers({
    --   function(server_name)
    --     require("lspconfig")[server_name].setup({})
    --   end,
    -- })
  end
}
