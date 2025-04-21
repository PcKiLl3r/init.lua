-- lua/pckill3r/core.lua

-- Autocommand groups
local augroup = vim.api.nvim_create_augroup
local PcKillerGroup = augroup("PcKiller", { clear = true })
local YankGroup = augroup("HighlightYank", { clear = true })

local autocmd = vim.api.nvim_create_autocmd

-- Highlight yanked text
autocmd("TextYankPost", {
  group = YankGroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 40,
    })
  end,
})

-- Trim trailing whitespace before saving
autocmd("BufWritePre", {
  group = PcKillerGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Dynamic colorscheme: Zig files use rose-pine, everything else tokyonight
autocmd("BufEnter", {
  group = PcKillerGroup,
  callback = function()
    local theme = vim.bo.filetype == "zig" and "rose-pine-moon" or "tokyonight-night"
    vim.cmd.colorscheme(theme)
  end,
})
