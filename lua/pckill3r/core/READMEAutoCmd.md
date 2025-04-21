# 📘 Neovim Autocommand & Autogroup Cheat Sheet

## 🧠 What is an Autocommand?

An `autocmd` tells Neovim:

> "When [some event] happens, run [this command or function]."

### Common Events
| Event         | When it triggers                      |
|---------------|---------------------------------------|
| `BufWritePre` | Before saving a file                  |
| `BufEnter`    | When switching to a file              |
| `TextYankPost`| After copying (yanking) text          |
| `InsertLeave` | When leaving insert mode              |
| `LspAttach`   | When the LSP connects to a buffer     |

---

## 🗂️ What is an Augroup?

An `augroup` groups related autocommands so you can:
- Keep things organized
- Cleanly reload them (`clear = true` clears old ones)

---

## 🔧 Examples

### 1. Highlight Yanked Text

```lua
local group = vim.api.nvim_create_augroup("HighlightYank", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 40 })
  end,
})
```

---

### 2. Trim Trailing Whitespace on Save

```lua
local group = vim.api.nvim_create_augroup("TrimWhitespace", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})
```

---

### 3. Set Colorscheme Based on Filetype

```lua
local group = vim.api.nvim_create_augroup("Themer", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  group = group,
  callback = function()
    if vim.bo.filetype == "zig" then
      vim.cmd.colorscheme("rose-pine-moon")
    else
      vim.cmd.colorscheme("tokyonight-night")
    end
  end,
})
```

---

### 4. LSP Keybindings on Attach

```lua
local group = vim.api.nvim_create_augroup("LspKeymaps", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(e)
    local opts = { buffer = e.buf }
    local map = vim.keymap.set

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    -- Add more as needed
  end,
})
```

---

## 💡 Notes
- Always use `clear = true` when defining augroups to avoid duplication on reloads
- Use `pattern = "*"` unless you want to restrict to certain filetypes or files
- Use `command =` for short Ex commands, `callback =` for full Lua logic
