You’ve got nvim-dap + nvim-dap-ui + mason-nvim-dap set up — that’s a powerful debugging combo 🎯

Let’s break down how to actually use it, step by step — no fluff, just practical.

🧪 1. What is nvim-dap?
It's a debugger client for Neovim, similar to how VSCode’s debugger works.

But unlike VSCode, you:

Configure debug adapters manually (per language)

Control everything via keymaps or Lua

You're using mason-nvim-dap, which simplifies adapter installation 🎉

🛠️ 2. Setup for a Language (e.g. Go)
You already have:

lua
Kopiraj
Uredi
ensure_installed = { "delve" }
So for Go, it installs the delve debugger and configures launch templates like:

lua
Kopiraj
Uredi
{
  type = "delve",
  name = "file args",
  request = "launch",
  program = "${file}",
}
🚀 3. How to Use It (Step-by-Step)
🔹 Start Debugging Session
🧷 Set breakpoints:

Press <leader>b — toggles a breakpoint at the current line

Press <leader>B — sets a conditional breakpoint (asks you for a condition)

📦 Run the debugger:

Press <F8> — this starts the debugger (runs your code until it hits a breakpoint)

If you’re asked for args (e.g. for Go), you’ll get a prompt: args >

🧭 Step through code:

<F10> → Step Over

<F11> → Step Into

<F12> → Step Out

🪟 Open UI windows:

<leader>dr → toggle REPL

<leader>ds → toggle Stacks

<leader>dw → toggle Watches

<leader>db → toggle Breakpoints list

<leader>dS → toggle Scopes

<leader>dc → toggle Console output

🛑 Stop the session:

Press :lua require('dap').terminate() or close the UI.

🧠 Tip: You can also launch DAP manually
lua
Kopiraj
Uredi
:lua require('dap').continue()
Or even define custom launch configs in your own Lua if you want total control.

👁 Example Workflow for Go
go
Kopiraj
Uredi
package main

import "fmt"

func main() {
  fmt.Println("Hello, debugger")
}
Put a breakpoint on fmt.Println(...) with <leader>b

Run with <F8>

Use <F10> to step over

Toggle UI with <leader>dc or others

🧩 Bonus: Add Watches or Evaluate Expressions
Inside the REPL (open with <leader>dr), you can type:

lua
Kopiraj
Uredi
print(someVariable)
Or in code:

lua
Kopiraj
Uredi
require("dapui").eval("someVar")
✅ Summary of Key Bindings (Default from your config)

Key	Action
<F8>	Continue
<F10>	Step Over
<F11>	Step Into
<F12>	Step Out
<leader>b	Toggle Breakpoint
<leader>B	Conditional Breakpoint
<leader>dr	Toggle REPL
<leader>db	Toggle Breakpoints Window
<leader>dc	Toggle Console
