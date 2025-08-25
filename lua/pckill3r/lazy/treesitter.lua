-- File: lua/pckill3r/lazy/treesitter.lua

return {
	-- 🌳 Main Treesitter engine
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- Ensure parsers are up to date when installing

		config = function()
			require("nvim-treesitter.configs").setup({
				-- ✅ Parsers to install
				ensure_installed = {
					"vimdoc",
					"javascript",
					"typescript",
					"tsx",
					"c",
					"lua",
					"rust",
					"html",
					"bash",
					"python",
					"angular",
					"scss",
					"markdown",
					"markdown_inline",
				},

				sync_install = false,
				auto_install = true,

				indent = {
					enable = true,
				},

				highlight = {
					enable = true,
					-- Disable for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							vim.notify(
								"Treesitter disabled (file >100KB)",
								vim.log.levels.WARN,
								{ title = "Treesitter" }
							)
							return true
						end
					end,
					additional_vim_regex_highlighting = { "markdown", "yaml" },
				},
			})

-- Keep only the working autocmd, remove all commented ones
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { "*.component.html", "*.container.html", "*.template.html" },
  callback = function()
    vim.bo.filetype = "htmlangular"
    -- Try html parser for better context support
    vim.treesitter.start(nil, "html")
    vim.defer_fn(function()
      require("treesitter-context").enable()
    end, 200)
  end,
})

-- Custom parser for .templ files
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.templ = {
  install_info = {
    url = "https://github.com/vrischmann/tree-sitter-templ.git",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "master",
  },
}

vim.treesitter.language.register("templ", "templ")
vim.treesitter.language.register("html", "htmlangular")


		end,
	},

	-- 📌 Treesitter context window (shows current scope at top)
	{
		"nvim-treesitter/nvim-treesitter-context",
		after = "nvim-treesitter",
		config = function()
			require("treesitter-context").setup({
				enable = true,
				max_lines = 3, -- Show up to 3 lines of context
				multiline_threshold = 20,
				trim_scope = "outer",
				mode = "cursor",
				separator = nil,
				zindex = 20,
				on_attach = function(buf)
					local ft = vim.bo[buf].filetype
					return ft ~= "help"
				end,
			})
		end,
	},
}
