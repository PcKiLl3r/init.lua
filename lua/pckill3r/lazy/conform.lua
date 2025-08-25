-- lua/pckill3r/lazy/conform.lua
return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				htmlangular = { "prettier" },
				html = { "prettier" },
        sh = { "shfmt" },
        go = { "gofmt" },
			},

			-- Optional: You can also customize specific formatter behavior
			-- formatters = {
			--   stylua = {
			--     prepend_args = { "--indent-width", "2" },
			--   },
			-- },
		})
	end,
}
