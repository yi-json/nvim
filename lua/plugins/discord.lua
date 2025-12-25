return {
	"andweeb/presence.nvim",
	config = function()
		require("presence").setup({
			-- General options
			auto_update         = true,
			neovim_image_text   = "The One True Editor",
			main_image          = "neovim", -- Can be "neovim" or "file"
			client_id           = "793271441293967371", -- Use default Neovim client ID
			log_level           = nil,
			debounce_timeout    = 10,
			enable_line_number  = false, -- Set to true if you want to show your line number
			blacklist           = {}, -- A list of strings or patterns to not expose
			buttons             = true, -- Configure buttons in Rich Presence
			file_assets         = {}, -- Custom file asset definitions
			show_time           = true, -- Show time spent in the file

			-- Rich Presence text config
			editing_text        = "Editing %s", -- Format string rendered when editing a file
			file_explorer_text  = "Browsing %s", -- Format string rendered when browsing a file explorer
			git_commit_text     = "Committing changes", -- Format string rendered when committing changes in git
			plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
			reading_text        = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded
			workspace_text      = "Working on %s", -- Format string rendered when in a git repository
			line_number_text    = "Line %s out of %s", -- Format string rendered when `enable_line_number` is set to true
		})
	end
}
