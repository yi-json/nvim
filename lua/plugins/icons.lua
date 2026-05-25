return {
    "nvim-tree/nvim-web-devicons",
    lazy = false,  -- load at startup so icons are available everywhere
    config = function()
        require("nvim-web-devicons").setup({
            default = true,  -- show a default icon for unknown file types
        })
    end,
}
