return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: open" },
		{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
	},
	config = function()
		require("diffview").setup({})
	end
}
