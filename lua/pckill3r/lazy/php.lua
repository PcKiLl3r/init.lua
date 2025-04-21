-- File: lua/pckill3r/lazy/php.lua

return {
  "tjdevries/php.nvim", -- 🐘 Experimental Tree-sitter-powered PHP helper

  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- 🌲 Required to analyze PHP structure
  },

  config = function()
    -- Initialize php.nvim (currently no config options required)
    require("php").setup({})
  end,
}
