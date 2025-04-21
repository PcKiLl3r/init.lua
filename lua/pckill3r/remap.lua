-- Set <space> as leader key
vim.g.mapleader = " "

-- File explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join lines but keep cursor in place
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor centered while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search terms centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste over selected text without yanking it
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete without yanking
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Map <C-c> to Escape in insert mode (personal preference)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable annoying Q
vim.keymap.set("n", "Q", "<nop>")

-- Open Tmux sessionizer
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Format buffer using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quickfix navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Location list navigation
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace word under cursor across the file
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Undo
vim.keymap.set("n", "<C-z>", ":u<CR>")
vim.keymap.set("i", "<C-z>", "<C-o>:u<CR>")

-- Cellular Automaton meme
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Source current file
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)


--[[vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)]]--

--vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/pckill3r/packer.lua<CR>");
