require("pckill3r")

vim.api.nvim_create_augroup("Mkdir", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
    group = "Mkdir",
    pattern = "*",
    callback = function()
        local dir = vim.fn.expand("<afile>:p:h")
        if vim.fn.isdirectory(dir) == 0 then
            vim.fn.mkdir(dir, "p")
        end
    end,
})
