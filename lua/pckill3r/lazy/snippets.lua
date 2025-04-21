-- File: lua/pckill3r/lazy/luasnip.lua

return {
  {
    "L3MON4D3/LuaSnip",  -- 🌱 The core Lua snippet engine

    version = "v2.*",    -- 📌 Use latest v2 release

    build = "make install_jsregexp",  -- 🔧 Optional: enables regex support for advanced snippets

    dependencies = {
      "rafamadriz/friendly-snippets", -- 📚 Community-contributed snippet library for many languages
    },

    config = function()
      local ls = require("luasnip")

      -- 👇 Extend javascript filetype to also include jsdoc snippets
      ls.filetype_extend("javascript", { "jsdoc" })

      -- ==========================
      -- 🔑 SNIPPET KEYBINDINGS
      -- ==========================

      -- ✨ Expand the current snippet trigger (if available)
      vim.keymap.set({ "i" }, "<C-s>e", function()
        ls.expand()
      end, { silent = true })

      -- 👉 Jump forward through snippet placeholders
      vim.keymap.set({ "i", "s" }, "<C-s>;", function()
        ls.jump(1)
      end, { silent = true })

      -- 👈 Jump backward through snippet placeholders
      vim.keymap.set({ "i", "s" }, "<C-s>,", function()
        ls.jump(-1)
      end, { silent = true })

      -- 🔁 Cycle through choice nodes (like alternatives)
      vim.keymap.set({ "i", "s" }, "<C-E>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { silent = true })
    end,
  },
}
