-- File: lua/pckill3r/lazy/treesitter.lua

return {
  -- 🌳 Main Treesitter engine
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    config = function()
      -- Temporarily treat markdown as regex-only to avoid extmark range bugs during edits.
-- Temporarily treat markdown and conf files as regex-only to avoid extmark range bugs during edits.
local disable_lang = {
  markdown = true,
  markdown_inline = true,
  conf = true,  -- Add this line
  hyprlang = true  -- Add this if you have hyprlang parser
}

      require("nvim-treesitter.configs").setup({
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
          -- keep markdown parsers installed, but we disable their TS highlight below
          "markdown",
          "markdown_inline",
        },

        -- While debugging crashes, avoid surprise auto-installs changing parser versions.
        auto_install = false,
        sync_install = false,

        indent = {
          -- Indent is another decoration provider; keep it on, but we disable it for very large files below.
          enable = true,
        },

        highlight = {
          enable = true,

          -- Disable TS highlight for markdown family (regex will take over) and for very large files.
          disable = function(lang, buf)
            if disable_lang[lang] then return true end

            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              vim.notify("Treesitter disabled (file >100KB)", vim.log.levels.WARN, { title = "Treesitter" })
              return true
            end
            return false
          end,

          -- Mixing regex + TS on markdown tends to duplicate ranges; turn it off while stabilizing.
          additional_vim_regex_highlighting = false,
        },
      })

      -------------------------------------------------------------------------
      -- HTML/Angular mapping
      -------------------------------------------------------------------------

      -- Map htmlangular filetype to use the HTML parser (no need to manually start TS).
      local ts_lang = vim.treesitter.language
      if ts_lang and ts_lang.register then
        ts_lang.register("html", "htmlangular")
        ts_lang.register("templ", "templ")
      end

      -- Custom parser for .templ files (unchanged)
      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

      -- IMPORTANT: Do NOT manually call vim.treesitter.start() here.
      -- Let nvim-treesitter attach based on 'filetype' only; double-attaches can cause extmark errors.

      -- Keep only the working autocmd: set proper filetype; no manual TS start; no manual context enable.
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        pattern = { "*.component.html", "*.container.html", "*.template.html" },
        callback = function(args)
          vim.bo[args.buf].filetype = "htmlangular"
          -- no manual TS start; the html parser is already mapped to htmlangular
        end,
      })
    end,
  },

  -- 📌 Treesitter context window (shows current scope at top)
  {
    "nvim-treesitter/nvim-treesitter-context",
    -- lazy.nvim no longer needs 'after'; plugin ordering is handled automatically.
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 3,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        separator = nil,
        zindex = 20,
        -- Avoid attaching in help and markdown to reduce injection pressure.
        on_attach = function(buf)
          local ft = vim.bo[buf].filetype
          if ft == "help" or ft == "markdown" or ft == "markdown_inline" then
            return false
          end
          return true
        end,
      })
    end,
  },
}
