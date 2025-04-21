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
