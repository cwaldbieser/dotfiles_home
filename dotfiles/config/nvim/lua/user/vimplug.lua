-- ========
-- Vim Plug
-- ========

local Plug = vim.fn['plug#']
vim.fn['plug#begin'](vim.fn.stdpath('data') .. '/plugged')
-- If you want to have icons in your statusline choose one of these
Plug('nvim-tree/nvim-web-devicons')
-- lualine
Plug('nvim-lualine/lualine.nvim')
-- NERDcomment
Plug('preservim/nerdcommenter')
-- vim-unimpared - shortcuts for paired operations like :lnext/:lprev
Plug('tpope/vim-unimpaired')
-- neoformat - code formatter
Plug('sbdchd/neoformat')
-- Git Fugitive
Plug('tpope/vim-fugitive')
-- Colorschemes
Plug('rockerBOO/boo-colorscheme-nvim')
Plug('challenger-deep-theme/vim', { as = 'challenger-deep' })
Plug('morhetz/gruvbox')
Plug('rafamadriz/neon')
Plug('EdenEast/nightfox.nvim')
Plug('haishanh/night-owl.vim')
Plug('arcticicestudio/nord-vim')
Plug('pineapplegiant/spaceduck', { branch = 'main' })
Plug('folke/tokyonight.nvim', { branch = 'main' })
Plug('Yagua/nebulous.nvim')
Plug('voidekh/kyotonight.vim')
Plug('rktjmp/lush.nvim') -- Required for bluloco
Plug('uloco/bluloco.nvim')
-- Colorscheme switcher.
Plug('xolox/vim-misc')
-- Plug('xolox/vim-colorscheme-switcher')
Plug('cwaldbieser/vim-colorscheme-switcher', { branch = 'lua-colors' })
-- Gitsigns
Plug('lewis6991/gitsigns.nvim')
-- Easymotion
Plug('easymotion/vim-easymotion')
-- Plenary
-- Required by other plugins; e.g. null-ls
Plug('nvim-lua/plenary.nvim')
-- LSP client configuration.
Plug('neovim/nvim-lspconfig')
-- none-ls integrates standalone tools as a language server
Plug('nvimtools/none-ls.nvim')
-- Completer coq-nvim
Plug('ms-jpq/coq_nvim', { branch = 'coq' })
Plug('ms-jpq/coq.artifacts', { branch = 'artifacts' })
-- Treesitter syntax highlighting
-- To install a given languare-- :TSInstall <language_to_install>
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
-- Which key
Plug('folke/which-key.nvim')
-- Lua colorschemes
Plug('tjdevries/colorbuddy.nvim')
Plug('lalitmee/cobalt2.nvim')
-- nvim-tree file explorer
Plug('nvim-tree/nvim-tree.lua')
-- Toggle term
Plug('akinsho/toggleterm.nvim', { ['tag'] = '2.3.0' })
-- Refactor tool
Plug('ThePrimeagen/refactoring.nvim')
-- Telescope
-- Requires plenary.nvim (see above)
-- Plug('nvim-telescope/telescope.nvim', { ['tag'] = '0.1.4' })
Plug('nvim-telescope/telescope.nvim')
-- Undo Tree
Plug('mbbill/undotree')
vim.fn['plug#end']()
