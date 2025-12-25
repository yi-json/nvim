-- Set <space> as the leader key
vim.g.mapleader = " "

-- PRESS "jk" TO EXIT INSERT MODE (Fastest way to exit!)
vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- CLEAR SEARCH HIGHLIGHTS (Press <Esc> to clear those yellow search boxes)
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>")

-- EASIER SAVE AND QUIT
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" }) -- Space + w
vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit all" }) -- Space + q

-- BETTER WINDOW NAVIGATION (Ctrl + h/j/k/l instead of Ctrl+w + h/j/k/l)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Select all with Ctrl + a
vim.keymap.set("n", "<C-a>", "gg<S-v>G", { desc = "Select all lines" })

-- Toggle comment with Ctrl + /
vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc", { remap = true })

-- Map Ctrl + _ (This is what most terminals ACTUALLY send for Ctrl+/)
vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle comment line" })
vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle comment selection" })

-- lua/config/keymaps.lua

-- Smart Home: Close Neo-tree/sidebars before going home to prevent errors
vim.keymap.set("n", "<leader>h", function()
	-- Close Neo-tree if it is open
	vim.cmd("Neotree close")

	-- Open Alpha (The Dashboard)
	vim.cmd("Alpha")
end, { desc = "Go to Home" })
