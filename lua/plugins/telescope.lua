return {
    'nvim-telescope/telescope.nvim', 
    branch = 'master',
    dependencies = { 'nvim-lua/plenary.nvim' },
    
    config = function()
        -- Get access to the telescope functions
        local builtin = require('telescope.builtin')

        -- Set up the keymaps
        -- <leader> is Space, so these commands are: Space + f + f
        vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
        vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end
}
