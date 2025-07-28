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
          "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust",
          "jsdoc", "bash", "python", "angular", "scss",
        },

        sync_install = false,
        auto_install = true,

        indent = {
          enable = true,
        },

        highlight = {
          enable = true,

          disable = {},
          -- Disable for large files or known problematic languages
          -- disable = function(lang, buf)
          --   if lang == "html" then
          --     print("Treesitter disabled for HTML (conflict prevention)")
          --     return true
          --   end
          --
          --   local max_filesize = 100 * 1024 -- 100 KB
          --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          --   if ok and stats and stats.size > max_filesize then
          --     vim.notify(
          --       "Treesitter disabled (file >100KB)",
          --       vim.log.levels.WARN,
          --       { title = "Treesitter" }
          --     )
          --     return true
          --   end
          -- end,

          additional_vim_regex_highlighting = { "markdown", "yaml" },
        },
      })

      -- 🌍 Load angular Treesitter for specific file patterns
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.component.html", "*.container.html" },
        callback = function()
          vim.treesitter.start(nil, "angular")
        end,
      })

      -- 🧩 Custom parser for `.templ` filetype
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

      vim.treesitter.language.register("templ", "templ")
    end
  },

  -- 📌 Treesitter context window (shows current scope at top)
  {
    "nvim-treesitter/nvim-treesitter-context",
    after = "nvim-treesitter",
    config = function()
      require("treesitter-context").setup({
        enable = true,
        multiwindow = false,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        on_attach = nil,
      })
    end
  }
}
