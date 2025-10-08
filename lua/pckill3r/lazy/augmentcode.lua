return {
  "AugmentCode/augment.vim",
  config = function()

    -- local cwd = vim.loop.cwd() or vim.fn.getcwd()
    -- vim.g.augment_workspace_folders = { cwd }

vim.g.augment_workspace_folders = {
  -- "/home/zorko/work/codeoath/WorkOath",
  "/home/pckill3r/.dotfiles",
  "/home/pckill3r/personal/linux-dev-playbook",
  -- "/home/zorko/.dotfiles/nvim",
  -- "/home/zorko/.dotfiles/bin",
  -- "/home/zorko/.dotfiles/hypr",
  -- "/home/zorko/.dotfiles/i3",
  -- "/home/zorko/.dotfiles/shell",
  -- "/home/zorko/.dotfiles/xkb",
  -- "/home/zorko/.dotfiles/zsh",
  -- "/home/zorko/.dotfiles/machine",
  -- "/home/zorko/.dotfiles/vpn",
  -- "/home/zorko/.dotfiles/treesitter",
  -- "/home/zorko/.dotfiles/tmux",
}

vim.g.augment_ignore_patterns = {
      "**/node_modules/**",
  -- "/home/zorko/.dotfiles/work/**",
  -- "/home/zorko/.dotfiles/projects/**",
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
