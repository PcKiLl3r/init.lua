-- ~/.config/nvim/lua/pckill3r/lazy/neo-tree.lua
return {
	-- "nvim-neo-tree/neo-tree.nvim",
	-- branch = "v3.x",
	-- dependencies = {
	--   "nvim-lua/plenary.nvim",
	--   "nvim-tree/nvim-web-devicons",
	--   "MunifTanjim/nui.nvim",
	--   -- keep the file-operations plugin in your runtime
	--   "antosha417/nvim-lsp-file-operations",
	-- },
	-- config = function()
	--   -- the lsp-file-operations setup can also live in its own file (above)
	--   require("neo-tree").setup({
	--     filesystem = {
	--       follow_current_file = { enabled = true },
	--       use_libuv_file_watcher = true,
	--     },
	--     window = {
	--       mappings = {
	--         ["r"] = "rename",  -- now triggers LSP edits
	--         ["m"] = "move",    -- now triggers LSP edits
	--       },
	--     },
	--   })
	--
	--   vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })
	--   -- vim.keymap.set("n", "<leader>pv", ":Neotree focus<CR>", { desc = "Focus Neo-tree" })
	-- end,

	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"antosha417/nvim-lsp-file-operations",
	},
	config = function()
		-- LSP file operations (import rewrites on rename/move)
		require("lsp-file-operations").setup()

		require("neo-tree").setup({
			close_if_last_window = true,
			enable_git_status = false,
			enable_diagnostics = false,

			default_component_configs = {
				indent = {
					with_markers = false,
					indent_size = 1,
				},
				icon = {
					-- Hide icons for a cleaner, netrw-ish look
					folder_closed = "",
					folder_open = "",
					folder_empty = "",
					default = "",
					highlight = "NeoTreeFileIcon",
				},
				modified = { symbol = "" },
				git_status = { symbols = {} },
			},

      -- popup_border_style = "rounded",
			window = {
				position = "float", -- use float instead of left
				popup = {
					size = {
						height = "100%",
						width = "100%",
					},
					position = "50%", -- center
				},
				-- position = "left",
				-- width = 28,
				-- Netrw-like keys
				-- mappings = {
				-- 	["<cr>"] = "open", -- open in current window
				-- 	["o"] = "open",
				-- 	["l"] = "open",
				-- 	["h"] = "close_node",
				-- 	["s"] = "open_split", -- horizontal split
				-- 	["v"] = "open_vsplit",
				-- 	["t"] = "open_tabnew",
				-- 	["-"] = "navigate_up", -- go up directory (netrw muscle memory)
				-- 	["_"] = "set_root", -- set current as root
				-- 	["q"] = "close_window",
				--
				-- 	-- file ops that trigger LSP edits
				-- 	["r"] = "rename",
				-- 	["m"] = "move",
				-- 	["d"] = "delete",
				-- 	["a"] = { "add", config = { show_path = "relative" } },
				-- },

       mappings = {
          -- netrw-like open/navigation
          ["<CR>"] = "open",
          ["o"]    = "open_split",   -- netrw: o = horizontal split
          ["v"]    = "open_vsplit",  -- netrw: v = vertical split
          ["t"]    = "open_tabnew",
          ["-"]    = "navigate_up",
          ["l"]    = "open",
          ["h"]    = "close_node",

          -- netrw-like file ops
          ["R"] = "rename",          -- LSP-aware import rewrites
          ["D"] = "delete",
          ["%"] = { "add", config = { show_path = "relative", kind = "file" } },
          ["d"] = { "add_directory", config = { show_path = "relative" } },

          -- extras that feel netrw-ish
          ["p"] = "preview",
          ["x"] = "system_open",
          ["q"] = "close_window",
        },
			},

			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
				-- hijack_netrw_behavior = "open_default", -- feel native when opening dirs
				hijack_netrw_behavior = "disabled", -- ← important: keep netrw as default
				filtered_items = {
					visible = true, -- show everything like netrw
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
			},
		})

		-- -- Toggle like netrw’s :Ex habit
		-- vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle Neo-tree" })

		vim.keymap.set("n", "<leader>E", function()
			vim.cmd("Neotree toggle left") -- sidebar on the left
		end, { desc = "Neo-tree sidebar" })

		vim.keymap.set("n", "<leader>e", function()
			vim.cmd("Neotree toggle float") -- fullscreen float
		end, { desc = "Neo-tree fullscreen" })
	end,
}
