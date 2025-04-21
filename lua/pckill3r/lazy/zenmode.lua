-- lua/pckill3r/lazy/zenmode.lua
return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      width = 90,
      options = {
        number = true,
        relativenumber = true,
      },
    },
  },
  config = function()
    require("zen-mode").setup({
      window = {
        width = 90,
        options = {
          number = true,
          relativenumber = true,
        },
      },
    })

    vim.keymap.set("n", "<leader>zz", function()
      require("zen-mode").toggle()
      vim.wo.wrap = false
      ColorMyPencils()
    end, { desc = "Toggle Zen Mode" })
  end,
}
