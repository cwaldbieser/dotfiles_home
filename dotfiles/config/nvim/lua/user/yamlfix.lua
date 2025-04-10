
M = {}

local null_ls = require("null-ls")
local h = require("null-ls.helpers")

-- Formatter source
local yamlfix_formatter_source = {}
yamlfix_formatter_source.method = null_ls.methods.FORMATTING
yamlfix_formatter_source.filetypes = { "yaml" }
yamlfix_formatter_source.generator = h.formatter_factory({
    command = "yamlfix",
    args = { "-" },
    to_stdin = true,
    use_cache = true,
    on_output = function(text, _)
        return {
            text = text
        }
    end,
})
M["formatter"] = yamlfix_formatter_source

return M
