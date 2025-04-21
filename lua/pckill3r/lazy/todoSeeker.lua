-- ~/.config/nvim/lua/pckill3r/lazy/todoSeeker.lua
return {
    dir = ".",
    name = "todoSeeker",
    config = function()
        local function find_todos()
            local current_dir = vim.fn.getcwd()
            local home_dir = vim.fn.expand('$HOME')
            local todos = {}

            while current_dir:find('^' .. home_dir) do
                local todo_path = current_dir .. '/todo.md'
                if vim.fn.filereadable(todo_path) == 1 then
                    table.insert(todos, {
                        filename = todo_path,
                        lnum = 1,
                        col = 1,
                        text = "Todo file found"
                    })
                end

                local parent = vim.fn.fnamemodify(current_dir, ':h')
                if parent == current_dir then break end
                current_dir = parent
            end

            if #todos > 0 then
                vim.fn.setqflist(todos)
                vim.cmd('copen')
            else
                print("No todo.md files found")
            end
        end

        vim.api.nvim_create_user_command('FindTodos', find_todos, {})
        --vim.keymap.set('n', '<Leader-t>', function() find_todos() end, { noremap = true, silent = true })
    end
}
