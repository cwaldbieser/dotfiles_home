local keymap_helper = {}

-- Helper function to add descriptions to keymap options.
-- e.g. keymap("v", "<", "<gv", add_desc(opts, 'Dedent block.'))
function keymap_helper.add_desc(opts, desc)
    local newopts = {}
    for k, v in pairs(opts) do
        newopts[k] = v
    end
    newopts['desc'] = desc
    return newopts
end

return keymap_helper
