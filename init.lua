-- -- early in init.lua / plugin `init()` (lazy) / `setup()` (packer)
-- local cwd = vim.loop.fs_realpath(vim.loop.cwd() or vim.fn.getcwd())
-- vim.g.augment_workspace_folders = { cwd }

-- Load main configuration module
require("pckill3r")

-- Automatically create missing directories on file save
vim.api.nvim_create_augroup("AutoMkdir", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "AutoMkdir",
    pattern = "*",
    callback = function()
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})

-- local preload_ts = vim.api.nvim_create_augroup("PreloadTS", {})
-- vim.api.nvim_create_autocmd("VimEnter", {
--   group = preload_ts,
--   once = true,
--   callback = function()
--     vim.cmd("vsplit | enew")
--     vim.bo.filetype = "typescript"
--     vim.defer_fn(function()
--       vim.cmd("close")
--     end, 500)
--   end,
-- })
