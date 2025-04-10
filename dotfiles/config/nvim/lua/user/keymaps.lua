-- ===================
-- User custom keymaps
-- ===================

-- Utility functions
local add_desc = require('user.keymap_helper').add_desc
local keymap = vim.api.nvim_set_keymap

-- Default options for keymaps.
local opts = { noremap = true, silent = true }

-- -------------------
-- Normal mode keymaps
-- -------------------

-- Alternate prefix for ctrl-w window commands.
-- Motivation is that when I port my configuration to an AWS Cloud9 setup, the
-- tty is accessed via a web browser.  For most web browsers, ctrl-w closes the
-- browser tab.
keymap("n", "<Leader>w", "<C-w>", add_desc(opts, "Alternate window command prefix."))

-- Cycle through open buffers.
keymap("n", "<S-Tab>", ":bnext<CR>", add_desc(opts, "Cycle through buffers."))

-- Toggle crosshairs for current position.
keymap("n", "<f2>", ":set cursorcolumn! <bar> set cursorline! <CR>", add_desc(opts, "Toggle crosshairs."))

-- Toggle column 80 highlight.
keymap("n", "<f3>", ':execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>',
    add_desc(opts, "Toggle column 80 highlight."))

-- Toggle undo tree.
keymap("n", "<f4>", ":UndotreeToggle<CR>", add_desc(opts, "Toggle Undotree"))

-- Remove trailing whitespace.
keymap("n", "<f5>", [[:let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>"endif]],
    add_desc(opts, "Remove trailing whitespace."))

-- Map f20 to shift-f8.
-- On my terminal, pressing shift-f8 generates the code for f20.
-- Allowing remapping here is intentional.
keymap("n", "<f20>", "<s-f8>", { silent = true })

-- Neoformat mapping.
keymap("n", "<f7>", ":Neoformat <CR>", add_desc(opts, "Invoke Neoformat."))

-- Toggle spell checking.
keymap("n", "<f9>", ":setlocal spell! <CR>", add_desc(opts, "Toggle spell checking."))

-- After paging half a screen, center the line in the middle of the screen.
keymap("n", "<C-d>", "<C-d>zz", add_desc(opts, "Scroll half page down."))
keymap("n", "<C-u>", "<C-u>zz", add_desc(opts, "Scroll half page up."))

-- Toggle file explorer
keymap("n", "<f1>", ":NvimTreeToggle<CR>", add_desc(opts, "Toggle file explorer."))

-- Toggle nebulous colorscheme modes.
keymap("n", "<F32>", ":lua require('nebulous.functions').toggle_variant()<CR>",
    add_desc(opts, "Cycle through nebulous colorscheme modes."))

-- Telescope keymaps
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fb', telescope_builtin.buffers, add_desc(opts, "List buffers."))
vim.keymap.set('n', '<leader>ff', telescope_builtin.find_files, add_desc(opts, "Find files."))
vim.keymap.set('n', '<leader>f.', function() telescope_builtin.find_files { hidden = true } end,
    add_desc(opts, "Find dotfiles."))
vim.keymap.set('n', '<leader>fg', telescope_builtin.live_grep, add_desc(opts, "Live grep."))
vim.keymap.set('n', '<leader>fh', telescope_builtin.help_tags, add_desc(opts, "Help tags."))
vim.keymap.set('n', '<leader>fr', telescope_builtin.registers, add_desc(opts, "List registers."))
vim.keymap.set('n', '<leader>fm', telescope_builtin.marks, add_desc(opts, "List marks."))
vim.keymap.set('n', '<leader>fs', telescope_builtin.treesitter, add_desc(opts, "Find symbols."))
vim.keymap.set('n', '<leader>fd', telescope_builtin.diagnostics, add_desc(opts, "Diagnostics."))
vim.keymap.set('n', '<leader>fc', telescope_builtin.colorscheme, add_desc(opts, "Colorschemes"))
vim.keymap.set('n', '<leader>fk', telescope_builtin.keymaps, add_desc(opts, "Keymaps"))
vim.keymap.set('n', '<leader>s', telescope_builtin.spell_suggest, add_desc(opts, "Spelling suggestions"))

-- -------------------
-- Insert mode keymaps
-- -------------------

-- Enter normal mode from Insert mode without having to stretch one's fingers
-- up to Esc.
keymap("i", "jk", "<esc>", add_desc(opts, "Enter Normal mode."))

-- -------------------
-- Visual mode keymaps
-- -------------------

-- When indenting / dedenting, retain the selection.
keymap("v", "<", "<gv", add_desc(opts, 'Dedent block.'))
keymap("v", ">", ">gv", add_desc(opts, 'Indent block.'))

-- Move blocks of text up and down.
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", add_desc(opts, 'Move block up 1 line.'))
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", add_desc(opts, 'Move block down 1 line.'))
