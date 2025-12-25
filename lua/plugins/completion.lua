return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- Source for LSP suggestions
		"L3MON4D3/LuaSnip", -- Snippet engine
		"saadparwaiz1/cmp_luasnip", -- Source for snippets
		"windwp/nvim-autopairs", -- Install autopairs
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")

		-- <--- ADDED: Load autopairs integration
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),

				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),

				['<CR>'] = cmp.mapping.confirm({ select = true }),

				['<C-Space>'] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			})
		})

		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)

		require("nvim-autopairs").setup({})
	end
}
