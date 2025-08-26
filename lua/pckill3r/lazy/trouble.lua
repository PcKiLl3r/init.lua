-- File: lua/pckill3r/lazy/trouble.lua

return {
  {
    "folke/trouble.nvim", -- 🚨 Diagnostics + list viewer (LSP, QF, etc.)
    config = function()
      -- require("trouble").setup({
      --   icons = false, -- Set to true if you want fancy symbols
      -- })

      local trouble = require("trouble")

      vim.keymap.set("n", "<leader>tt", function() trouble.toggle("diagnostics") end,
        { desc = "Trouble: Toggle Diagnostics" })
      vim.keymap.set("n", "<leader>tw", function() trouble.toggle("workspace_diagnostics") end,
        { desc = "Trouble: Workspace Diagnostics" })
      vim.keymap.set("n", "<leader>td", function() trouble.toggle("document_diagnostics") end,
        { desc = "Trouble: File Diagnostics" })
      vim.keymap.set("n", "<leader>tq", function() trouble.toggle("quickfix") end, { desc = "Trouble: Quickfix List" })
      vim.keymap.set("n", "<leader>tl", function() trouble.toggle("loclist") end, { desc = "Trouble: Location List" })
      vim.keymap.set("n", "<leader>tr", function() trouble.toggle("lsp_references") end,
        { desc = "Trouble: LSP References" })

      vim.keymap.set("n", "[t", function() trouble.next({ skip_groups = true, jump = true }) end,
        { desc = "Trouble: Next Item" })
      vim.keymap.set("n", "]t", function() trouble.previous({ skip_groups = true, jump = true }) end,
        { desc = "Trouble: Previous Item" })
    end
  }
}
