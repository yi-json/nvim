return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local dashboard = require("alpha.themes.dashboard")

		-- 1. HEADER
		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
		}

		-- 2. BUTTONS
		dashboard.section.buttons.val = {
			dashboard.button("e", "  New File", ":ene <BAR> startinsert <CR>"),
			dashboard.button("f", "  Find File", ":Telescope find_files <CR>"),
			dashboard.button("r", "  Recent Files", ":Telescope oldfiles <CR>"),
			dashboard.button("t", "  Find Text", ":Telescope live_grep <CR>"),
			dashboard.button("c", "  Config", ":e $MYVIMRC <CR>"),
			dashboard.button("q", "  Quit", ":qa<CR>"),
		}

		-- 3. PHILOSOPHICAL QUOTES (Wrapped to ~65 chars)
		local quotes = {
			{ text = { "He who has a why to live can bear almost any how." },                                                                  author = "Friedrich Nietzsche" },
			{ text = { "And those who were seen dancing were thought to be insane", "by those who could not hear the music." },                author = "Friedrich Nietzsche" },
			{ text = { "We are what we repeatedly do.", "Excellence, then, is not an act, but a habit." },                                     author = "Aristotle" },
			{ text = { "The more you know, the more you know you don't know." },                                                               author = "Aristotle" },
			{ text = { "Two things awe me most, the starry sky above me", "and the moral law within me." },                                    author = "Immanuel Kant" },
			{ text = { "Wise men speak because they have something to say;", "Fools because they have to say something." },                    author = "Plato" },
			{ text = { "The only true wisdom is in knowing you know nothing." },                                                               author = "Socrates" },
			{ text = { "An unexamined life is not worth living." },                                                                            author = "Socrates" },
			{ text = { "You have power over your mind - not outside events.", "Realize this, and you will find strength." },                   author = "Marcus Aurelius" },
			{ text = { "The happiness of your life depends upon", "the quality of your thoughts." },                                           author = "Marcus Aurelius" },
			{ text = { "It is not enough to have a good mind;", "the main thing is to use it well." },                                         author = "Rene Descartes" },
			{ text = { "Luck is what happens when preparation meets opportunity." },                                                           author = "Seneca" },
			{ text = { "We suffer more often in imagination than in reality." },                                                               author = "Seneca" },
			{ text = { "It does not matter how slowly you go as long as you do not stop." },                                                   author = "Confucius" },
			{ text = { "The journey of a thousand miles begins with a single step." },                                                         author = "Lao Tzu" },
			{ text = { "No man ever steps in the same river twice." },                                                                         author = "Heraclitus" },
			{ text = { "It's not what happens to you,", "but how you react to it that matters." },                                             author = "Epictetus" },
			{ text = { "Judge a man by his questions rather than by his answers." },                                                           author = "Voltaire" },
			{ text = { "I have striven not to laugh at human actions,", "not to weep at them, nor to hate them,", "but to understand them." }, author = "Baruch Spinoza" },
			{ text = { "No man's knowledge here can go beyond his experience." },                                                              author = "John Locke" },
		}

		local function get_quote()
			math.randomseed(os.time())
			local selected = quotes[math.random(#quotes)]

			local max_width = 0
			for _, line in ipairs(selected.text) do
				if #line > max_width then
					max_width = #line
				end
			end

			local formatted = {}
			for _, line in ipairs(selected.text) do
				table.insert(formatted, line)
			end

			table.insert(formatted, "")

			local author_str = "- " .. selected.author
			local padding_len = max_width - #author_str

			if padding_len > 0 then
				local padding = string.rep(" ", padding_len)
				table.insert(formatted, padding .. author_str)
			else
				table.insert(formatted, author_str)
			end

			return formatted
		end

		dashboard.section.footer.val = get_quote()

		-- 4. STYLING
		vim.api.nvim_set_hl(0, "AlphaHeaderYellow", { fg = "#FAC863" })
		vim.api.nvim_set_hl(0, "AlphaFooterPink", { fg = "#F28FAD" })
		vim.api.nvim_set_hl(0, "AlphaShortcutRed", { fg = "#F44747" })

		dashboard.section.header.opts.hl = "AlphaHeaderYellow"
		dashboard.section.buttons.opts.hl = "AlphaButtons"
		dashboard.section.footer.opts.hl = "AlphaFooterPink"

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl_shortcut = "AlphaShortcutRed"
		end

		-- 5. LAYOUT
		dashboard.section.header.opts.position = "center"
		dashboard.section.buttons.opts.position = "center"
		dashboard.section.footer.opts.position = "center"

		dashboard.config.layout = {
			{ type = "padding", val = 4 },
			dashboard.section.header,
			{ type = "padding", val = 2 },
			dashboard.section.buttons,
			{ type = "padding", val = 2 },
			dashboard.section.footer,
		}

		require("alpha").setup(dashboard.config)
	end,
}
