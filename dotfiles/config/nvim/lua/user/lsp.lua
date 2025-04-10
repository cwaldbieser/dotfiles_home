-- =============================================
-- Neovim Language Server Protocol configuration
-- =============================================

-- Utility functions.
local add_desc = require('user.keymap_helper').add_desc
local set_jedi_virtualenv = require("user.jedi-virtualenv-helper").set_jedi_virtualenv

-- telescope builtins
local tscope_builtin = require("telescope.builtin")
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer.
-- `on_attach(client, bufnr)`
local function attach_factory(disabled_features)
    local on_attach = function(client, bufnr)
        set_jedi_virtualenv(client)
        --print("attached " .. client.name)
        local sc = client.server_capabilities
        if disabled_features.hoverProvider then
            sc.hoverProvider = false
        end
        -- Enable completion triggered by <c-x><c-o>
        --vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', {buf = bufnr})
        local leader_temp = vim.g.mapleader
        vim.g.mapleader = ' '
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, add_desc(bufopts, 'Get help on symbol under cursor.'))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, add_desc(bufopts, 'Go to definition.'))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, add_desc(bufopts, 'Go to implementation.'))
        vim.keymap.set('n', 'gr', tscope_builtin.lsp_references, add_desc(bufopts, 'Show references.'))
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, add_desc(bufopts, 'Go to declaration.'))
        vim.keymap.set('n', '<space>K', vim.lsp.buf.signature_help, add_desc(bufopts, 'Signature help.'))
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, add_desc(bufopts, 'Go to type definition.'))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, add_desc(bufopts, 'Rename symbol.'))
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, add_desc(bufopts, 'Code action.'))
        vim.keymap.set('v', '<leader>ca', vim.lsp.buf.code_action, add_desc(bufopts, 'Code action.'))
        vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end,
            add_desc(bufopts, 'Format code.'))
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, add_desc(bufopts, 'Show diagnostics in float.'))
        vim.keymap.set('n', '<leader>l', vim.diagnostic.setloclist,
            add_desc(bufopts, 'Send diagnostics to location list.'))
        vim.keymap.set('n', '<leader>d', tscope_builtin.diagnostics, add_desc(bufopts, 'Diagnostics.'))
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, add_desc(bufopts, 'Previous diagnostic.'))
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, add_desc(bufopts, 'Next diagnostic.'))
        vim.g.mapleader = leader_temp
        -- This should really be conditional depending on the LSP server.
        vim.opt.formatexpr = ""
    end
    return on_attach
end

local on_attach = attach_factory({})

local lsp = require('lspconfig')

-- ------------------------------------
-- Python language server configuration
-- ------------------------------------
lsp.jedi_language_server.setup {
    on_attach = on_attach,
}

--lsp.ruff_lsp.setup {
--    on_attach = attach_factory({ hoverProvider = true }),
--}

-- ----------------------------------------
-- TypeScript language server configuration
-- ----------------------------------------
lsp.ts_ls.setup {
    on_attach = on_attach,
}

-- -------------------
-- Lua language server
-- -------------------
lsp.lua_ls.setup {
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                -- Suppress workspace query for VS Code.
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}

-- -----------------------------
-- LSP diagnostics configuration
-- -----------------------------
-- Configure diagnositcs icons on the line number column.
-- This replaces plain E W signs to more fun ones.
-- !IMPORTANT: nerdfonts needs to be setup for this to work in your terminal.
local signs = { Error = "❗", Warn = " ", Hint = "🔍", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end


-- -------------------------
-- Toggle Diagnostics on/off
-- -------------------------
vim.g.diagnostics_active = true
function _G.toggle_diagnostics()
    if vim.g.diagnostics_active then
        vim.g.diagnostics_active = false
        vim.diagnostic.disable(0)
    else
        vim.g.diagnostics_active = true
        vim.diagnostic.enable(0)
    end
end

local leader_temp = vim.g.mapleader
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<leader>tt', ':call v:lua.toggle_diagnostics()<CR>', { noremap = true, silent = true })
vim.g.mapleader = leader_temp
