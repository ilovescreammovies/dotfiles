local map = vim.keymap.set

map('n', '<leader>bd', '<cmd>bd<CR>', { desc = '[B]uffer [D]elete' })
map('n', '<Esc>', '<cmd>nohlsearch')
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
