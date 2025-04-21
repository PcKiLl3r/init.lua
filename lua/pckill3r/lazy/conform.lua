-- lua/pckill3r/lazy/conform.lua
return {
  "stevearc/conform.nvim",

  -- Optional global options (can be left empty or used for future custom behavior)
  opts = {},

  config = function()
    -- Load the conform plugin
    require("conform").setup({

      -- Specify which formatters to use per filetype
      formatters_by_ft = {
        -- For Lua files, use 'stylua' (must be installed on your system)
        lua = { "stylua" },

        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        sh = { "shfmt" },
        go = { "gofmt" },

        -- You can extend this list like so:
        -- javascript = { "prettier" },
        -- go = { "gofmt" },
        -- sh = { "shfmt" },
      },

      -- Optional: You can also customize specific formatter behavior
      -- formatters = {
      --   stylua = {
      --     prepend_args = { "--indent-width", "2" },
      --   },
      -- },
    })
  end,
}
