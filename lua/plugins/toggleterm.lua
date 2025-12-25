return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 10,
			open_mapping = [[<c-\>]], -- The key to toggle the terminal
			direction = 'horizontal', -- 'vertical' | 'horizontal' | 'tab' | 'float'
			shade_filetypes = {},
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true, -- Whether or not the open mapping applies in insert mode
			persist_size = true,
			close_on_exit = true, -- Close the terminal window when the process exits
			shell = vim.o.shell, -- Change the default shell
		})
	end
}
