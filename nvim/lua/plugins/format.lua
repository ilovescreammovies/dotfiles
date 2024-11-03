return {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
        {
            '<leader>bf',
            function()
                require('conform').format({ async = true, lsp_format = 'fallback' })
            end,
            mode = 'n',
            desc = '[B]uffer [F]ormat',
        },
    },
    opts = {
        notify_on_error = false,
        format_on_save = false,
        formatters_by_ft = {
            lua = { 'stylua' },
            javascript = { 'prettier' },
            typescript = { 'prettier' },
        },
    },
}
