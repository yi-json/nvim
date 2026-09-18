require("config.keymaps")
require("config.lazy")
require("config.templates")

-- Absolute Line Numbers
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = false -- Use absolute numbers, not relative

-- Set tab width to 4 spaces
vim.opt.tabstop = 4      -- Width of a tab character
vim.opt.shiftwidth = 4   -- Size of an indent (when you hit Tab)
vim.opt.expandtab = true -- Convert tabs to spaces (recommended)
vim.opt.softtabstop = 4  -- Makes Backspace delete 4 spaces like a Tab

vim.opt.clipboard = "unnamedplus"

-- Auto-reload buffers when their file changes on disk (e.g. edited in another
-- nvim instance) instead of showing stale content until manually reloaded.
vim.opt.autoread = true

-- Better Line Wrapping (for md)
vim.opt.wrap = true         -- Enable line wrapping
vim.opt.linebreak = true    -- Wrap lines at convenient points (avoid splitting words)
vim.opt.breakindent = true  -- Wrapped lines will keep the same indent level
