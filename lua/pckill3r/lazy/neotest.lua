-- File: lua/pckill3r/lazy/neotest.lua

return {
  "nvim-neotest/neotest",

  -- Dependencies required for test adapters and test execution
  dependencies = {
    "nvim-neotest/nvim-nio",                     -- Async I/O
    "nvim-lua/plenary.nvim",                     -- Required by many plugins
    "antoinemadec/FixCursorHold.nvim",           -- Fixes CursorHold delay (for test results to show correctly)
    "nvim-treesitter/nvim-treesitter",           -- Syntax tree support (used by test adapters)
    "fredrikaverpil/neotest-golang",             -- Go test adapter
    "leoluz/nvim-dap-go",                        -- Go debugger adapter (used by DAP strategy)
  },

  config = function()
    -- 🔧 Setup neotest with Go adapter
    require("neotest").setup({
      adapters = {
        require("neotest-golang")({
          dap = { justMyCode = false }, -- Show all code (not just user's code) during debugging
        }),
      },
    })

    -- 🔁 Run nearest test
    vim.keymap.set("n", "<leader>tr", function()
      require("neotest").run.run({
        suite = false, -- only nearest test
        testify = true, -- use testify package in Go
      })
    end, { desc = "Debug: Run Nearest Test" })

    -- 📊 Toggle test summary panel
    vim.keymap.set("n", "<leader>tv", function()
      require("neotest").summary.toggle()
    end, { desc = "Debug: Toggle Test Summary" })

    -- 📦 Run entire test suite
    vim.keymap.set("n", "<leader>ts", function()
      require("neotest").run.run({
        suite = true, -- run whole test suite
        testify = true,
      })
    end, { desc = "Debug: Run Full Test Suite" })

    -- 🐞 Debug nearest test with DAP
    vim.keymap.set("n", "<leader>td", function()
      require("neotest").run.run({
        suite = false,
        testify = true,
        strategy = "dap", -- run using nvim-dap (debugger)
      })
    end, { desc = "Debug: Debug Nearest Test" })

    -- 📥 Open test output window
    vim.keymap.set("n", "<leader>to", function()
      require("neotest").output.open()
    end, { desc = "Debug: Open Test Output" })

    -- 🚀 Run all tests in current working directory
    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.run(vim.fn.getcwd())
    end, { desc = "Debug: Run All Tests in Project" })
  end,
}
