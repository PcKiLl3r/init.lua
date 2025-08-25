-- File: lua/pckill3r/lazy/lsp.lua
return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"stevearc/conform.nvim",
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		-- Capabilities for LSP completion
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = cmp_lsp.default_capabilities()

		-- LSP progress/status UI
		require("fidget").setup({})
		require("mason").setup()

		-- Setup LSP servers
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"gopls",
			},
		})

		local lspconfig = require("lspconfig")

		-- Default setup for most servers
		lspconfig.rust_analyzer.setup({ capabilities = capabilities })
		lspconfig.gopls.setup({ capabilities = capabilities })

		-- Lua server with custom settings
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					runtime = { version = "Lua 5.1" },
					diagnostics = {
						globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
					},
				},
			},
		})

		-- Zig server (if you use it)
		lspconfig.zls.setup({
			capabilities = capabilities,
			root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
		})

		-- Extra LSP for Angular (not managed via Mason)
		require("lspconfig").angularls.setup({
			capabilities = capabilities,
			filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx", "htmlangular" },
			root_dir = require("lspconfig").util.root_pattern("angular.json", "project.json", "package.json", ".git"),
		})

		-- nvim-cmp completion setup
		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-p>"] = cmp.mapping.select_prev_item(),
				["<C-n>"] = cmp.mapping.select_next_item(),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			}),
			sources = {
				{ name = "copilot", group_index = 2 },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
			},
		})

		-- Configure diagnostics floating popup
		vim.diagnostic.config({
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
