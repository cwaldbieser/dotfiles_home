-- Filetype detection
vim.cmd('filetype plugin on')
-- Visual cues for my current position.
-- Make the current line number stand out from the relative line numbers.
vim.cmd('hi CursorLineNR cterm=bold ctermbg=234 gui=bold guibg=#202020')
--  Make spelling errors stand out even when row is highlighted.
vim.cmd('hi SpellBad cterm=underline')
-- Configure the color column.
vim.cmd('hi ColorColumn cterm=bold ctermbg=darkgrey gui=bold guibg=#202020')

-- RST customizations
local augroup_rst = vim.api.nvim_create_augroup('myrestructuredtext', { clear = true })

vim.api.nvim_create_autocmd('Filetype', {
    pattern = 'rst',
    group = augroup_rst,
    command = 'colorscheme duskfox',
})

-- Javascript customizations.
local augroup_js = vim.api.nvim_create_augroup('myjsbindings', { clear = true })

vim.api.nvim_create_autocmd('Filetype', {
    pattern = 'javascript',
    group = augroup_js,
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end
})
