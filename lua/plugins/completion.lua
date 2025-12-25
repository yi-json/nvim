return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",     -- Source for LSP suggestions
        "L3MON4D3/LuaSnip",         -- Snippet engine (Required for cmp to work!)
        "saadparwaiz1/cmp_luasnip", -- Source for snippets
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                -- TAB to select next suggestion
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                -- SHIFT + TAB to select previous suggestion
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),

                -- ENTER to confirm selection
                ['<CR>'] = cmp.mapping.confirm({ select = true }),

                -- CTRL + SPACE to trigger menu manually
                ['<C-Space>'] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'nvim_lsp' }, -- Get suggestions from LSP (clangd, rust_analyzer)
                { name = 'luasnip' },  -- Get suggestions from snippets
            })
        })
    end
}
