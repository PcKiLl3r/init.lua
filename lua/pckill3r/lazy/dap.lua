-- Define a group for DAP-related autocommands
vim.api.nvim_create_augroup("DapGroup", { clear = true })

return {
	-- 🔌 Core DAP engine
	{
		"mfussenegger/nvim-dap",
		lazy = false,
		config = function()
			local dap = require("dap")
			dap.set_log_level("DEBUG") -- optional debugging output

			-- Basic debugging keymaps
			vim.keymap.set("n", "<F8>", dap.continue, { desc = "Debug: Continue" })
			vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Conditional Breakpoint" })
		end,
	},

	-- 🖼️ UI for nvim-dap (windows for stack, scopes, etc.)
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio", -- Required for DAP UI
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Simple keymaps to toggle UI
			vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
			vim.keymap.set("n", "<leader>dr", function()
				dapui.open({ layout = 2 })
			end, { desc = "Debug: Open REPL" })
			vim.keymap.set("n", "<leader>dc", function()
				dapui.close()
			end, { desc = "Debug: Close UI" })

			-- Enable soft wrapping inside the REPL buffer
			vim.api.nvim_create_autocmd("BufEnter", {
				group = "DapGroup",
				pattern = "*dap-repl*",
				callback = function()
					vim.wo.wrap = true
				end,
			})

			-- Simple UI setup
			dapui.setup({
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.25 },
							{ id = "breakpoints", size = 0.25 },
							{ id = "stacks", size = 0.25 },
							{ id = "watches", size = 0.25 },
						},
						size = 40,
						position = "left",
					},
					{
						elements = {
							{ id = "repl", size = 0.5 },
							{ id = "console", size = 0.5 },
						},
						size = 10,
						position = "bottom",
					},
				},
			})

			-- Automatically close UI when debug session ends
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
		end,
	},

	-- 📦 Automatic installation & setup of DAP adapters via Mason
	{
		"jay-babu/mason-nvim-dap.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"mfussenegger/nvim-dap",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "delve", "js-debug-adapter" },
				automatic_installation = true,
			})

			-- Simple Go debugger config
			local dap = require("dap")
			dap.configurations.go = {
				{
					type = "delve",
					name = "Debug",
					request = "launch",
					program = "${file}",
				},
				{
					type = "delve",
					name = "Debug with args",
					request = "launch",
					program = "${file}",
					args = function()
						return vim.split(vim.fn.input("Args: "), " ")
					end,
				},
			}
			-- TypeScript/Angular debugger config
			dap.configurations.typescript = {
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Debug Angular App",
					url = "http://localhost:4200",
					webRoot = "${workspaceFolder}",
					skipFiles = {
						"<node_internals>/**",
						"node_modules/**",
					},
				},
			}

			dap.configurations.javascript = dap.configurations.typescript

			local js_debug_path = vim.fn.stdpath("data")
				.. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_path, "${port}" },
				},
			}

			dap.adapters["pwa-chrome"] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = { js_debug_path, "${port}" },
				},
			}
		end,
	},
}
