================================================================================

	*You*

Let's bind something in neovim that will allow me to set current netrw directory as root and allow me to fzf through it as with pf as if I opened nvim there.

--------------------------------------------------------------------------------

	*Augment*

You can create a keybinding that sets the current netrw directory as root and updates telescope's search scope. Add this to your `nvim/.config/nvim/lua/pckill3r/remap.lua`:

````lua path=nvim/.config/nvim/lua/pckill3r/remap.lua mode=EDIT
-- Set netrw directory as project root and search from there
vim.keymap.set("n", "<leader>pr", function()
    local current_dir = vim.fn.expand('%:p:h')
    vim.cmd('cd ' .. current_dir)
    require('telescope.builtin').find_files({ cwd = current_dir })
end, { desc = "Set current dir as root and find files" })
````

This gives you `<leader>pr` (project root) that:
1. Changes Neovim's working directory to the current file's directory
2. Opens telescope `find_files` scoped to that directory

If you want it to work specifically when you're in netrw, you can make it more targeted:

````lua path=nvim/.config/nvim/lua/pckill3r/remap.lua mode=EDIT
-- Netrw-specific: set current directory as root
vim.keymap.set("n", "<leader>pr", function()
    local current_dir
    if vim.bo.filetype == "netrw" then
        current_dir = vim.fn.expand('%')  -- netrw directory
    else
        current_dir = vim.fn.expand('%:p:h')  -- file's directory
    end
    vim.cmd('cd ' .. current_dir)
    require('telescope.builtin').find_files({ cwd = current_dir })
end, { desc = "Set current/netrw dir as root and find files" })
````

Now when you're browsing in netrw, `<leader>pr` will make that directory your project root and let you `<leader>pf` through it as if you opened nvim there.


================================================================================
