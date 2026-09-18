return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                markdown = { "mdformat", "clang-format-docs", "mdcodefmt" },

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
                -- Runs clang-format on fenced ```cpp/```c blocks inside markdown.
                -- Operates in place on the file (no stdin support), and exits 1
                -- when it rewrote something (not an error) vs 0 when unchanged.
                ["clang-format-docs"] = {
                    command = "clang-format-docs",
                    args = { "--style={BasedOnStyle: LLVM, IndentWidth: 4, UseTab: Never}", "$FILENAME" },
                    stdin = false,
                    exit_codes = { 0, 1 },
                },
                -- Runs the matching formatter (black/prettier/shfmt/rustfmt/gofmt)
                -- on fenced python/js/ts/bash/rust/go blocks inside markdown.
                -- Same in-place, exit-1-means-changed convention as clang-format-docs.
                ["mdcodefmt"] = {
                    command = vim.fn.stdpath("config") .. "/bin/mdcodefmt",
                    args = { "$FILENAME" },
                    stdin = false,
                    exit_codes = { 0, 1 },
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
