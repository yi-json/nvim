return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                markdown = { "mdformat" },

                -- Use "stylua" for Lua
                lua = { "stylua" },
                cpp = { "clang-format" },
                c = { "clang-format" },
                rust = { "rustfmt" }
            },

            formatters = {
                mdformat = {
                    -- Wraps paragraph text at 60 columns instead of leaving it on one line.
                    prepend_args = { "--wrap", "60" },
                },
                ["clang-format"] = {
                    -- "IndentWidth: 4" forces 4 spaces.
                    -- "UseTab: Never" ensures it uses spaces, not \t characters.
                    prepend_args = { "-style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}" },
                },
            },

            -- Set up Format on Save
            format_on_save = {
                lsp_fallback = true, -- If no formatter is found, use the LSP (Essential for C++/Rust/Go!)
                async = false,
                timeout_ms = 500,
            },
        })
    end
}
