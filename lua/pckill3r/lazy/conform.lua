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
  css = { "prettier" },
  scss = { "prettier" },
  yaml = { "prettier" },
  sh = { "shfmt" },
  bash = { "shfmt" },
  go = { "gofmt" },
  python = { "black" },
  rust = { "rustfmt" },
  c = { "clang-format" },
  cpp = { "clang-format" },
  java = { "google-java-format" },
  php = { "php_cs_fixer" },
  ruby = { "rubocop" },
  sql = { "sqlfluff" },
  xml = { "xmlformat" },
  dockerfile = { "hadolint" },
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
