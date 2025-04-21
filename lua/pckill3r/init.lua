-- Basic config
-- Load Neovim options
require("pckill3r.set")

-- Load key mappings
require("pckill3r.remap")

-- Initialize plugin manager and plugins
require("pckill3r.lazy_init")

-- Core logic: autocommands, filetypes, netrw tweaks, etc.

require("pckill3r.core.utils")

require("pckill3r.core.autocmds")

require("pckill3r.core.filetypes")

require("pckill3r.core.lsp_keymaps")

require("pckill3r.core.netrw")

-- DO NOT INCLUDE THIS

-- If i want to keep doing lsp debugging
-- function restart_htmx_lsp()
--     require("lsp-debug-tools").restart({ expected = {}, name = "htmx-lsp", cmd = { "htmx-lsp", "--level", "DEBUG" }, root_dir = vim.loop.cwd(), });
-- end

-- DO NOT INCLUDE THIS
