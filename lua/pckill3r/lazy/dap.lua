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
    end
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

      -- Define layout configuration for each UI component
      local function layout(name)
        return {
          elements = {
            { id = name },
          },
          size = 40,
          position = "right",
        }
      end

      -- Create a mapping of component names to layouts
      local name_to_layout = {
        repl = { layout = layout("repl"), index = 0 },
        stacks = { layout = layout("stacks"), index = 0 },
        scopes = { layout = layout("scopes"), index = 0 },
        console = { layout = layout("console"), index = 0 },
        watches = { layout = layout("watches"), index = 0 },
        breakpoints = { layout = layout("breakpoints"), index = 0 },
      }

      -- Build layout list from the above table
      local layouts = {}
      for name, config in pairs(name_to_layout) do
        table.insert(layouts, config.layout)
        name_to_layout[name].index = #layouts
      end

      -- Function to toggle individual UI components
      local function toggle_debug_ui(name)
        dapui.close()
        local layout_config = name_to_layout[name]
        if layout_config == nil then
          error(string.format("bad name: %s", name))
        end
        dapui.toggle(layout_config.index)
      end

      -- Keymaps to toggle individual windows
      vim.keymap.set("n", "<leader>dr", function() toggle_debug_ui("repl") end, { desc = "Debug: toggle REPL UI" })
      vim.keymap.set("n", "<leader>ds", function() toggle_debug_ui("stacks") end, { desc = "Debug: toggle Stacks UI" })
      vim.keymap.set("n", "<leader>dw", function() toggle_debug_ui("watches") end, { desc = "Debug: toggle Watches UI" })
      vim.keymap.set("n", "<leader>db", function() toggle_debug_ui("breakpoints") end, { desc = "Debug: toggle Breakpoints UI" })
      vim.keymap.set("n", "<leader>dS", function() toggle_debug_ui("scopes") end, { desc = "Debug: toggle Scopes UI" })
      vim.keymap.set("n", "<leader>dc", function() toggle_debug_ui("console") end, { desc = "Debug: toggle Console UI" })

      -- Enable soft wrapping inside the REPL buffer
      vim.api.nvim_create_autocmd("BufEnter", {
        group = "DapGroup",
        pattern = "*dap-repl*",
        callback = function()
          vim.wo.wrap = true
        end,
      })

      -- Load dap-ui layouts
      dapui.setup({ layouts = layouts })

      -- Automatically close UI when debug session ends
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- Optional: show output in console pane
      dap.listeners.after.event_output.dapui_config = function(_, body)
        if body.category == "console" then
          dapui.eval(body.output)
        end
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
        ensure_installed = {
          "delve", -- Go debugger
        },
        automatic_installation = true,

        -- Optional: custom configuration for specific debuggers
        handlers = {
          function(config)
            require("mason-nvim-dap").default_setup(config)
          end,

          -- 🔧 Configure `delve` for Go debugging
          delve = function(config)
            table.insert(config.configurations, 1, {
              args = function() return vim.split(vim.fn.input("args> "), " ") end,
              type = "delve",
              name = "file",
              request = "launch",
              program = "${file}",
              outputMode = "remote",
            })
            table.insert(config.configurations, 1, {
              args = function() return vim.split(vim.fn.input("args> "), " ") end,
              type = "delve",
              name = "file args",
              request = "launch",
              program = "${file}",
              outputMode = "remote",
            })
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      })
    end,
  },
}
