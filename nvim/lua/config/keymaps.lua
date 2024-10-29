local map = vim.keymap.set

map('n', '<Esc>', ':nohlsearch<CR>')

-- Buffers
map('n', '<leader>bd', ':bd<CR>', { desc = '[B]uffer [D]elete' })
map('n', '<S-h>', ':bprevious<CR>')
map('n', '<S-l>', ':bnext<CR>')

-- Windows
map('n', '<C-h>', '<C-w><C-h>')
map('n', '<C-l>', '<C-w><C-l>')
map('n', '<C-j>', '<C-w><C-j>')
map('n', '<C-k>', '<C-w><C-k>')
