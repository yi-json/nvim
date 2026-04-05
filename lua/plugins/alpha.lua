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

        local quotes = {
            { text = { "The use of COBOL cripples the mind; its teaching should,", "therefore, be regarded as a criminal offense." },                                                                                    author = "Edsger W. Dijkstra" },
            { text = { "We've tended to forget that no computer", "will ever ask a new question." },                                                                                                                     author = "Grace Hopper" },
            { text = { "A distributed system is one in which the failure", "of a computer you didn't even know existed can", "render your own computer unusable." },                                                     author = "Leslie Lamport" },
            { text = { "If a machine is expected to be infallible,", "it cannot also be intelligent." },                                                                                                                 author = "Alan Turing" },
            { text = { "Theory and practice sometimes clash. And when", "that happens, theory loses. Every single time." },                                                                                              author = "Linus Torvalds" },
            { text = { "There are two ways of constructing a software design:", "make it so simple that there are obviously no", "deficiencies, or make it so complicated that", "there are no obvious deficiencies." }, author = "Tony Hoare" },
            { text = { "Debugging is twice as hard as writing the code.", "Therefore, if you write the code as cleverly as", "possible, you are, by definition,", "not smart enough to debug it." },                     author = "Brian Kernighan" },
            { text = { "I call it my billion-dollar mistake...", "the invention of the null reference." },                                                                                                               author = "Tony Hoare" },
            { text = { "Some people, when confronted with a problem, think", "'I know, I'll use regular expressions.'", "Now they have two problems." },                                                                 author = "Jamie Zawinski" },
            { text = { "UNIX is basically a simple operating system,", "but you have to be a genius", "to understand the simplicity." },                                                                                 author = "Dennis Ritchie" },
            { text = { "Anyone who considers arithmetical methods", "of producing random digits is, of course,", "in a state of sin." },                                                                                 author = "John von Neumann" },
            { text = { "There are only two hard things in Computer Science:", "cache invalidation and naming things." },                                                                                                 author = "Phil Karlton" },
            { text = { "Beware of bugs in the above code;", "I have only proved it correct, not tried it." },                                                                                                            author = "Donald Knuth" },
            { text = { "A language that doesn't affect the way you think", "about programming is not worth knowing." },                                                                                                  author = "Alan Perlis" },
            { text = { "One of my most productive days was", "throwing away 1,000 lines of code." },                                                                                                                     author = "Ken Thompson" },
            { text = { "Adding manpower to a late software project", "makes it later." },                                                                                                                                author = "Fred Brooks" },
            { text = { "If you're thinking without writing,", "you only think you're thinking." },                                                                                                                       author = "Leslie Lamport" },
            { text = { "The most disastrous thing that you can ever learn", "is your first programming language." },                                                                                                     author = "Alan Kay" },
            { text = { "Premature optimization is the root of all evil." },                                                                                                                                              author = "Donald Knuth" },
            { text = { "Always code as if the guy who ends up maintaining", "your code will be a violent psychopath", "who knows where you live." },                                                                     author = "John Woods" },
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
