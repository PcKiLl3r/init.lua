-- Cursor
vim.opt.guicursor = ""
-- vim.opt.guicursor=a:blinkon100

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Line wrapping
vim.opt.wrap = true

-- Swap and backup files
vim.opt.swapfile = false
vim.opt.backup = false

-- Undo history
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"

-- File name characters
vim.opt.isfname:append("@-@")

-- Update time
vim.opt.updatetime = 50

-- vim.opt.conceallevel = 1
