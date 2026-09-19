-- Uses the `main` branch: `master` is frozen/legacy and breaks on Neovim 0.12+.
-- `main` has no `configs.setup{ ensure_installed, highlight }` module, so
-- parser installation and highlighting are wired up manually below.
-- Compiling parsers needs the `tree-sitter` CLI (brew install tree-sitter-cli).
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- main does not support lazy-loading
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.setup({})

		-- Async; already-installed parsers are skipped.
		ts.install({
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
		})

		-- Highlighting is no longer a plugin option; start it per buffer.
		-- pcall: silently skip filetypes with no parser installed.
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterHighlight", { clear = true }),
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
			end,
		})
	end,
}
