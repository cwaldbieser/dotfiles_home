local M = {}

M["pysqlmagic"] = function()
    local bufnr = 0
    local tree = vim.treesitter.get_parser(bufnr, "python"):parse()[1]
    local query = vim.treesitter.query.parse(
        "python",
        [[
            (assignment 
              left: (identifier) @id (#match? @id "sql")
              right: [
                (string) @sql_string
                (binary_operator
                    left: (string) @sql_string
                    right: (parenthesized_expression)
                )
              ]
            )
        ]])
    -- id, node, metadata
    for id, node, _ in query:iter_captures(tree:root(), bufnr) do
        if id == 2 and node:type() == "string" then
            local r0, c0, r1, c1 = node:range()
            local lines = vim.api.nvim_buf_get_lines(bufnr, r0, r1 + 1, true)
            local i0 = #lines
            --local fh = io.popen("python -c 'import sys; print(eval(sys.stdin.read()))'")
            local tempname = os:tmpname()
            local fh = io.open(tempname, "w")
            if fh == nil then
                print("(1) Could not open temp file!")
                return
            end
            for i, line in pairs(lines) do
                if i == i0 then
                    line = line:sub(1, c1 + 1)
                end
                if i == 1 then
                    line = line:sub(c0 + 1)
                end
                fh:write(line .. "\n")
            end
            fh:close()
            local ph = io.popen("cat " ..
                tempname .. " | python -c 'import sys; print(eval(sys.stdin.read()))'")
            if ph == nil then
                print("(1) Could not open process pipeline!")
                return
            end
            local data = ph:read("*a")
            ph:close()
            fh = io.open(tempname, "w")
            if fh == nil then
                print("(2) Could not open temp file!")
                return
            end
            fh:write(data)
            fh:close()
            ph = io.popen("sqlformat -k upper -i lower -r " .. tempname)
            if ph == nil then
                print("(1) Could not open process pipeline!")
                return
            end
            data = ph:read("*a")
            ph:close()
            os.remove(tempname)
            -- print(data)
            local indent = string.rep(" ", c0)
            local fmtlines = {'"""\\'}
            for s in data:gmatch("[^\r\n]+") do
                table.insert(fmtlines, indent .. s)
            end
            table.insert(fmtlines, indent .. '"""')
            vim.api.nvim_buf_set_text(0, r0, c0, r1, c1, fmtlines)
        end
    end
end
vim.api.nvim_create_user_command("PySQLMagic", ':lua require("user.pysql").pysqlmagic()<CR>', {})
return M
