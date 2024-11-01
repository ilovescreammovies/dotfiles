return {
    'tpope/vim-sleuth',
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = { signs = false },
    },
    {
        'm4xshen/autoclose.nvim',
        opts = {},
    },
}
