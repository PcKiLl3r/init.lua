local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("LspAttach", {
  group = PcKillerGroup,
  callback = function(e)
    local opts = { buffer = e.buf }
    local map = vim.keymap.set

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
    map("n", "<leader>vd", function() vim.diagnostic.open_float({ focusable = true }) end, opts)
    map("n", "<leader>vca", vim.lsp.buf.code_action, opts)
    map("n", "<leader>vrr", vim.lsp.buf.references, opts)
    map("n", "<leader>vrn", vim.lsp.buf.rename, opts)
    map("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    map("n", "[d", vim.diagnostic.goto_next, opts)
    map("n", "]d", vim.diagnostic.goto_prev, opts)

-- -- Pseudocode – only if the plugin exposes such a helper.
-- vim.keymap.set("n", "<leader>fr", function()
--   local old = vim.fn.expand("%:p")
--   local new = vim.fn.input("Rename to: ", old, "file")
--   if new ~= "" and new ~= old then
--     require("lsp-file-operations").rename(old, new) -- hypothetical
--   end
-- end, { desc = "LSP-aware file rename" })

  end,
})
