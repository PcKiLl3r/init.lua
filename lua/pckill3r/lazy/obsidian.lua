-- lua/pckill3r/lazy/obsidian.lua
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  ft = "markdown", -- lazy-load on MD files
  enabled = function()
    local uv = vim.uv or vim.loop
    local function exists(p) return p and uv.fs_stat(vim.fs.normalize(p)) ~= nil end

    -- Your known vaults (can be many)
    local VAULTS = {
      "~/work/codeoath/WorkOath",
      "~/notes/personal",
    }

    for _, v in ipairs(VAULTS) do
      if exists(vim.fn.expand(v)) then return true end
    end
    -- No vaults on this machine? Don’t load the plugin at all.
    return false
  end,

  opts = function()
    local uv = vim.uv or vim.loop
    local function exists(p) return p and uv.fs_stat(vim.fs.normalize(p)) ~= nil end
    local function expand(p) return vim.fs.normalize(vim.fn.expand(p)) end

    local VAULTS = {
      { name = "WorkOath", path = "~/work/codeoath/WorkOath" },
      { name = "personal", path = "~/notes/personal" },
    }

    -- Keep only vaults that actually exist here
    local workspaces = {}
    for _, v in ipairs(VAULTS) do
      if exists(expand(v.path)) then table.insert(workspaces, v) end
    end

    return {
      workspaces = workspaces,
      -- ...your other obsidian.nvim opts...
    }
  end,
}
-- return {
--   {
--     -- You can swap to "obsidian-nvim/obsidian.nvim" if you prefer the community fork
--     "epwalsh/obsidian.nvim",
--     version = "*",
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-telescope/telescope.nvim", -- for vault search pickers
--     },
--     opts = {
--       workspaces = {
--         { name = "vault", path = "~/work/codeoath/WorkOath" }, -- <- change to your path
--       },
--       templates = {
--         folder = "templates",
--         date_format = "%Y-%m-%d",
--         time_format = "%H:%M",
--       },
--       daily_notes = {
--         folder = "daily",
--         date_format = "%Y-%m-%d",
--         template = "daily-note.md", -- uses templates/daily-note.md
--       },
--       -- templates/backlinks/etc. can be added later without changing the structure
--     },
--   },
-- }
