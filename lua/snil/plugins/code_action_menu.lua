return {
    {
        'weilbith/nvim-code-action-menu',
        keys = {{'<leader>ca', '<cmd>CodeActionMenu<cr>'}},
        dependencies = {'kosayoda/nvim-lightbulb'}
    }, {
        'kosayoda/nvim-lightbulb',
        dependencies = {'antoinemadec/FixCursorHold.nvim'},
        config = function()
            require('nvim-lightbulb').setup({
                autocmd = {enabled = true},
                sign = {enabled = false},
                virtual_text = {enabled = true, text = ''}
            })
        end
    }
}
