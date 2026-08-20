return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        -- 1. Setup Mason (The installer)
        require("mason").setup()

        -- 2. Setup Mason-LSPConfig (The bridge)
        require("mason-lspconfig").setup({
            ensure_installed = { "lua_ls", "clangd", "rust_analyzer", "gopls" },
            
            -- THIS IS THE FIX: Automatic setup for all servers
            handlers = {
                function(server_name)
                    require("lspconfig")[server_name].setup({})
                end,
            }
        })

        -- 3. Keymaps (Same as before - these work for all languages)
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            end,
        })

        -- 4. Diagnostics: show the actual error text, not just the sign
        vim.diagnostic.config({
            virtual_text = { source = true, prefix = "●" },
            float = { source = true, border = "rounded" },
            severity_sort = true,
        })

        vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "Diagnostics: show line error" })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostics: prev" })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostics: next" })

        -- auto-popup the full diagnostic message when the cursor rests on an error line
        vim.api.nvim_create_autocmd('CursorHold', {
            group = vim.api.nvim_create_augroup('UserDiagnosticHover', {}),
            callback = function()
                vim.diagnostic.open_float(nil, { focus = false })
            end,
        })
    end
}
