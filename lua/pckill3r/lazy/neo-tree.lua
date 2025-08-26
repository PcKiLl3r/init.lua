-- return {
--   -- "nvim-neo-tree/neo-tree.nvim",
--   -- branch = "v3.x",
--   -- dependencies = {
--   --   "nvim-lua/plenary.nvim",
--   --   "nvim-tree/nvim-web-devicons",
--   --   "MunifTanjim/nui.nvim",
--   -- },
--   -- config = function()
--   --   require("neo-tree").setup({
--   --     close_if_last_window = false,
--   --     popup_border_style = "rounded",
--   --     enable_git_status = true,
--   --     enable_diagnostics = true,
--   --
--   --     filesystem = {
--   --       follow_current_file = {
--   --         enabled = true,
--   --       },
--   --       use_libuv_file_watcher = true,
--   --     },
--   --
--   --     window = {
--   --       position = "left",
--   --       width = 30,
--   --       mapping_options = {
--   --         noremap = true,
--   --         nowait = true,
--   --       },
--   --       mappings = {
--   --         ["<space>"] = "none",
--   --         ["<cr>"] = "open",
--   --         ["o"] = "open",
--   --         ["S"] = "open_split",
--   --         ["s"] = "open_vsplit",
--   --         ["t"] = "open_tabnew",
--   --         ["C"] = "close_node",
--   --         ["z"] = "close_all_nodes",
--   --         ["R"] = "refresh",
--   --         ["a"] = "add",
--   --         ["A"] = "add_directory",
--   --         ["d"] = "delete",
--   --         ["r"] = "rename",
--   --         ["m"] = "move_and_update_imports", -- Custom move command
--   --         ["c"] = "copy",
--   --         ["x"] = "cut_to_clipboard",
--   --         ["p"] = "paste_from_clipboard",
--   --         ["q"] = "close_window",
--   --         ["?"] = "show_help",
--   --       },
--   --     },
--   --   })
--   --
--   --   -- Keymaps
--   --   vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
--   --   vim.keymap.set("n", "<leader>pv", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })
--   -- end,
-- }


-- ~/.config/nvim/lua/pckill3r/lazy/neo-tree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- keep the file-operations plugin in your runtime
    "antosha417/nvim-lsp-file-operations",
  },
  config = function()
    -- the lsp-file-operations setup can also live in its own file (above)
    require("neo-tree").setup({
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["r"] = "rename",  -- now triggers LSP edits
          ["m"] = "move",    -- now triggers LSP edits
        },
      },
    })

    vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
    -- vim.keymap.set("n", "<leader>pv", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })
  end,
}
