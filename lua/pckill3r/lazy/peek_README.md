 What is toppair/peek.nvim?
peek.nvim lets you preview Markdown (.md) files live in your browser directly from Neovim — kind of like a built-in markdown server viewer.

It's useful when you're writing:

README.md

Documentation

Notes

Blog posts

🧠 Your Config Explained
lua
Kopiraj
Uredi
return {
  {
    "toppair/peek.nvim",

    -- Only load this plugin when necessary (optimizes startup)
    event = { "VeryLazy" },

    -- Build step: Compiles the Deno-based preview server
    build = "deno task --quiet build:fast",

    config = function()
      require("peek").setup({
        filetype = { "markdown", "conf" } -- Enable for .md and .conf files
      })

      -- User command: :PeekOpen to open the preview in your browser
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})

      -- User command: :PeekClose to close the preview window
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
}
⚙️ What It Actually Does

Feature	Description
VeryLazy	Loads only when needed (not during startup)
deno task	Compiles the backend viewer (requires Deno)
:PeekOpen	Opens your current Markdown file in a browser tab
:PeekClose	Closes the browser preview
filetype	Only activates for .md or .conf files
🧪 Usage Example
You're editing README.md, then:

vim
Kopiraj
Uredi
:PeekOpen
✅ A live preview opens in your browser (served locally).
Edit the file → it updates automatically.

When you're done:

vim
Kopiraj
Uredi
:PeekClose
📦 Requirements
To use this plugin, you need:

✅ Deno installed
Install it via:

bash
Kopiraj
Uredi
brew install deno        # macOS
choco install deno       # Windows
scoop install deno       # Windows
✅ A browser (any modern one) — Peek will launch a local server for preview

✅ Summary

Thing	What it does
peek.nvim	Live Markdown preview in your browser
:PeekOpen	Opens the preview window
:PeekClose	Closes the preview window
deno task build	Builds the preview server using Deno
Lazy-loaded	Doesn’t slow down startup (loads on demand)
