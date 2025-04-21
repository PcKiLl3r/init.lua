🔍 What Does conform.nvim Do?
conform.nvim is a format-on-save plugin for Neovim. It’s:

⚡ Fast (async formatting)

🔧 Pluggable (pick your formatter per language)

🧼 Simple to configure and extend

✅ LSP-agnostic (works with external tools like prettier, stylua, etc.)

It's like null-ls but focused purely on formatting.

🔧 Your Config Explained
lua
Kopiraj
Uredi
return {
  'stevearc/conform.nvim',
  opts = {},
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
      }
    })
  end
}
🔹 What this does:

Part	Meaning
formatters_by_ft	Table mapping filetypes to formatter(s)
lua = { "stylua" }	Use stylua (a fast Lua formatter) to format Lua files
opts = {}	Default options, not used in this case (but can hold global settings)
require("conform").setup(...)	Initializes the plugin with your formatters
💡 How to Use It
Out of the box:

Format on save is not enabled by default

But you can easily do:

🔧 Enable Format on Save (in your core/autocmds.lua or conform config):
lua
Kopiraj
Uredi
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
This runs formatting before saving any file.

🚀 Extend It for More Languages
Here's how you might add other formatters:

lua
Kopiraj
Uredi
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    markdown = { "prettier" },
    sh = { "shfmt" },
    go = { "gofmt" },
  },
})
➡️ You need those tools installed (e.g. npm i -g prettier, brew install shfmt, etc.)

🧩 Bonus: Formatter Options
You can customize each formatter’s behavior:

lua
Kopiraj
Uredi
formatters = {
  stylua = {
    prepend_args = { "--indent-width", "2" },
  },
}
✅ Summary

Feature	Description
conform.nvim	Format-on-save framework for Neovim
stylua	Formatter used for Lua files (configured in your setup)
Easy to extend	Add formatters per filetype
Optional: auto-format	Use BufWritePre to format before saving
