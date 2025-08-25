return {
  "AugmentCode/augment.vim",
  config = function()

    -- local cwd = vim.loop.cwd() or vim.fn.getcwd()
    -- vim.g.augment_workspace_folders = { cwd }

vim.g.augment_workspace_folders = {
  "/home/zorko/work/codeoath/WorkOath",
  "/home/zorko/work/agenda/zrsz/zrsz-urban",
  "/home/zorko/.dotfiles/nvim/.config/nvim",
}

    -- Required: set your API key (from https://augmentcode.com/)
    vim.g.augment_api_key = os.getenv("AUGMENT_API_KEY") or "your-api-key-here"

    -- Optional: keymaps
-- Lua mapping examples
vim.keymap.set('n', '<leader>ac', ':Augment chat<CR>', { desc = 'Augment chat' })
vim.keymap.set('v', '<leader>ac', ':Augment chat<CR>', { desc = 'Augment chat (visual)' })
vim.keymap.set('n', '<leader>an', ':Augment chat-new<CR>', { desc = 'Augment chat new' })
vim.keymap.set('n', '<leader>at', ':Augment chat-toggle<CR>', { desc = 'Augment chat toggle' })
  end,
}
