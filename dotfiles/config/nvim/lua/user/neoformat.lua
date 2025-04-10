-- =======================
-- Neoformat configuration
-- =======================

vim.g.neoformat_run_all_formatters = 1

-- Uncomment for debugging.
--vim.g.neoformat_verbose = 1

-- SQL
vim.g.neoformat_sql_sqlformat = {
    exe = 'sqlformat',
    stdin = 1,
    args = { '--reindent', '--keywords', 'upper', '-' }
}
