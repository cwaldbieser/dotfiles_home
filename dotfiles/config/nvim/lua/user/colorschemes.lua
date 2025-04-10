-- --------------------------
-- Colorschemes configuration
-- --------------------------

require('bluloco').setup()

-- Set the colorscheme.
vim.cmd('colorscheme night-owl')

-- "nebulous" variant switcher
-- :lua require("nebulous.functions").toggle_variant()

-- -----------------------
-- Configure colorswitcher
-- -----------------------

--vim.g.colorscheme_switcher_exclude_builtins = 1
vim.g.colorscheme_switcher_exclude = {
    "dawnfox",
    "default",
    "delek",
    "desert",
    "elflord",
    "evening",
    "habamax",
    "industry",
    "koehler",
    "morning",
    "murphy",
    "pablo",
    "peachpuff",
    "quiet",
    "radioactive_waste",
    "ron",
    "shine",
    "slate",
    "tokyonight-day",
    "torte",
    "zellner",
}
vim.g.colorscheme_switcher_command = "ColorSwitch"

local function swtchcolors(opts)
    local cs = opts["args"]
    local colorbuddy_schemes = {
        ["cobalt2"] = true,
    }
    local require_setup_schemes = {
        ["onenord"] = true,
        ["nebulous"] = true,
    }
    if colorbuddy_schemes[cs] then
        package.loaded['colorbuddy'] = nil
        package.loaded[cs] = nil
        require('colorbuddy').colorscheme(cs)
    elseif require_setup_schemes[cs] then
        package.loaded[cs] = nil
        require(cs).setup()
    else
        vim.cmd("colorscheme " .. cs)
    end
end

vim.api.nvim_create_user_command("ColorSwitch", swtchcolors, {nargs=1, complete="color"})
