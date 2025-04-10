-- =======================
-- Completer configuration
-- =======================

-- Autostart completer.
vim.g.coq_settings = { auto_start = 'shut-up' }

-- Import the completer module.
require('coq')
