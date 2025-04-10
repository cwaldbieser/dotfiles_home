
-- Register's the Python standard library's `json.tool` as a JSON linter.
-- It only shows one diagnostic at a time.

M = {}

local null_ls = require("null-ls")
local h = require("null-ls.helpers")

-- Linter source
local jsontool_linter_source = {}
jsontool_linter_source.method = null_ls.methods.DIAGNOSTICS
jsontool_linter_source.filetypes = { "json" }
jsontool_linter_source.generator = h.generator_factory({
    command = "python",
    args = { "-m", "json.tool" },
    to_stdin = true,
    from_stderr = true,
    format = "line",
    use_cache = true,
    on_output = function(line, _)
        local pattern = [[([^:]+): line (%d+) column (%d+) %(char %d+%)]]
        local result = { line:match(pattern) }
        local message = result[1]
        local lineno = tonumber(result[2])
        local column = tonumber(result[3])
        return {
            col = column,
            row = lineno,
            message = message,
            severity = 1,
            source = "json.tool"
        }
    end,
})
M["diagnostic"] = jsontool_linter_source

-- Formatter source
local jsontool_formatter_source = {}
jsontool_formatter_source.method = null_ls.methods.FORMATTING
jsontool_formatter_source.filetypes = { "json" }
jsontool_formatter_source.generator = h.formatter_factory({
    command = "python",
    args = { "-m", "json.tool", "--sort-keys" },
    to_stdin = true,
    use_cache = true,
    on_output = function(text, _)
        return {
            text = text
        }
    end,
})
M["formatter"] = jsontool_formatter_source

return M
