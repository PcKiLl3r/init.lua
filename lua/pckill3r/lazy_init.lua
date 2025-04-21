-- lua/pckill3r/lazy_init.lua

-- Path where lazy.nvim will be installed (if not already)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Automatically clone lazy.nvim if it's not installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Initialize lazy.nvim and load plugin specs
require("lazy").setup({
  spec = "pckill3r.lazy", -- points to lua/pckill3r/lazy/init.lua
  change_detection = {
    notify = false, -- Don’t show notifications when plugin config changes
  }
})
