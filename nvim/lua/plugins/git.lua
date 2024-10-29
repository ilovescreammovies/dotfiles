return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
                untracked = { text = '┆' },
            },
            current_line_blame = true,
        })

        local map = vim.keymap.set
        -- Stage
        map('n', '<leader>gs', ':Gitsigns stage_hunk<CR>')
        map('v', '<leader>gs', ':Gitsigns stage_hunk<CR>')
        map('n', '<leader>gS', '<cmd>Gitsigns stage_buffer<CR>')
        -- Reset
        map('n', '<leader>gr', ':Gitsigns reset_hunk<CR>')
        map('v', '<leader>gr', ':Gitsigns reset_hunk<CR>')
    end,
}
