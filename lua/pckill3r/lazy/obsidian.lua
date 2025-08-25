return {
  {
    -- You can swap to "obsidian-nvim/obsidian.nvim" if you prefer the community fork
    "epwalsh/obsidian.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim", -- for vault search pickers
    },
    opts = {
      workspaces = {
        { name = "vault", path = "~/work/codeoath/WorkOath" }, -- <- change to your path
      },
      templates = {
        folder = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
      },
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        template = "daily-note.md", -- uses templates/daily-note.md
      },
      -- templates/backlinks/etc. can be added later without changing the structure
    },
  },
}
