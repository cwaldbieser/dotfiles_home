-- Register ``rstfmt`` as a ReStructuredText formatter.

M = {}

local null_ls = require("null-ls")
local h = require("null-ls.helpers")

-- Formatter source
local rstfmt_formatter_source = {}
rstfmt_formatter_source.method = null_ls.methods.FORMATTING
rstfmt_formatter_source.filetypes = { "rst" }
rstfmt_formatter_source.generator = h.formatter_factory({
    command = "rstfmt",
    to_stdin = true,
    use_cache = true,
    on_output = function(text, _)
        return {
            text = text
        }
    end,
})
M["formatter"] = rstfmt_formatter_source

return M
