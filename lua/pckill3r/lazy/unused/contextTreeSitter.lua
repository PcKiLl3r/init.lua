return {
  "nvim-treesitter/nvim-treesitter-context",
  after = "nvim-treesitter", -- Load only after base treesitter is ready

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
