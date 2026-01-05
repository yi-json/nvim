return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- Adds file type icons
        "MunifTanjim/nui.nvim",
    },
    config = function()
        -- Setup Neo-tree options to show hidden files
        require("neo-tree").setup({
            filesystem = {
                filtered_items = {
                    visible = true,          -- This makes hidden files visible by default
                    hide_dotfiles = false,
                    hide_gitignored = false, -- Important for seeing build output like 'out/' folders
                },
            },
        })
        -- Set up the keymap: Space + e to toggle the explorer
        vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>', { desc = 'Toggle File Explorer' })
    end
}
