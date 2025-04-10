require("toggleterm").setup({
    open_mapping = [[<f13>]],
    float_opts = {
        border = "curved"
    },
    size=function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
end
})

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<C-esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>w', [[<Cmd>wincmd w<CR>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Utility functions
local add_desc = require('user.keymap_helper').add_desc
local keymap = vim.api.nvim_set_keymap
-- Default options for keymaps.
local opts = { noremap = true, silent = true }

-- <f13> => <S-f1>
keymap("n", "<f13>", "<cmd>ToggleTerm direction=horizontal<CR>", add_desc(opts, "Open terminal horizontal."))
keymap("t", "<f13>", "<cmd>ToggleTerm direction=horizontal<CR>", add_desc(opts, "Open terminal horizontal."))
-- <f25> => <C-f1>
keymap("n", "<f25>", "<cmd>ToggleTerm direction=float<CR>", add_desc(opts, "Open terminal floating."))
keymap("t", "<f25>", "<cmd>ToggleTerm direction=float<CR>", add_desc(opts, "Open terminal floating."))
-- <f49> => <M-f1>
keymap("n", "<f49>", "<cmd>ToggleTerm direction=vertical<CR>", add_desc(opts, "Open terminal vertical."))
keymap("t", "<f49>", "<cmd>ToggleTerm direction=vertical<CR>", add_desc(opts, "Open terminal vertical."))
