-- ==============
-- Neovim options
-- ==============

-- Tab expansion is 4 spaces.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Python support.
vim.g.python3_host_prog = '/home/carl/.virtualenvs/neovim.py3.12/bin/python3'

-- Line numbering
vim.opt.rnu = true
vim.opt.nu = true

-- Allow switching buffers when there are unsaved changes.
vim.opt.hidden = true

-- Don't highlight all matching searches.
vim.opt.hls = false

-- Allow syntax highlighting for embedded lua and Python.
vim.g.vimsyn_embed = 'lP'

-- Activate termguicolors.
vim.opt.termguicolors = true

-- disabled providers.
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
