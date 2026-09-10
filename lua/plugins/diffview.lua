return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Diffview: open" },
		{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Diffview: close" },
	},
	config = function()
		require("diffview").setup({})

		-- Auto-refresh the diff/file panel when files change on disk,
		-- even if the edit happened in a different nvim process/terminal.
		local group = vim.api.nvim_create_augroup("DiffviewAutoRefresh", { clear = true })
		local watch_handle, debounce_timer

		local function refresh()
			if debounce_timer then
				debounce_timer:stop()
			end
			debounce_timer = vim.defer_fn(function()
				-- Reload any open buffers whose file changed on disk, then
				-- recompute the diff highlighting, before refreshing the
				-- file panel/stats. Without this the panel updates but the
				-- already-open diff panes keep showing stale hunks.
				vim.cmd("silent! checktime")
				vim.cmd("silent! diffupdate")
				require("diffview").emit("refresh_files")
			end, 150)
		end

		local function stop_watch()
			if watch_handle then
				watch_handle:stop()
				watch_handle:close()
				watch_handle = nil
			end
		end

		local function start_watch()
			stop_watch()
			local root = vim.fn.systemlist("git rev-parse --show-toplevel")[1] or vim.fn.getcwd()
			local handle = vim.uv.new_fs_event()
			watch_handle = handle
			handle:start(root, { recursive = true }, function(err, _, _)
				if err then return end
				vim.schedule(refresh)
			end)
		end

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "DiffviewViewOpened",
			callback = start_watch,
		})
		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "DiffviewViewClosed",
			callback = stop_watch,
		})
	end
}
