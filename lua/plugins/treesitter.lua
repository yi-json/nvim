return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"cpp",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"go",
				"rust",
				"bash",
				"json",
				"yaml",
				"toml",
				"html",
				"css",
				"sql",
				"markdown",
				"markdown_inline",
				"lua",
				"vim",
				"vimdoc",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}
