return {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        'MunifTanjim/nui.nvim',
    },
    opts = {},
    config = function()
        vim.keymap.set(
            'n',
            '<space>te',
            '<cmd>Neotree filesystem toggle reveal right<CR>',
            { desc = '[T]oggle [E]xplorer' }
        )
    end,
}
