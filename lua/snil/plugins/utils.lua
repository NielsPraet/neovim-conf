return {
    {'jghauser/mkdir.nvim', event = "GUIEnter"},
    {'wakatime/vim-wakatime', event = "VimEnter"}, {
        'Saecki/crates.nvim',
        ft = {'toml'},
        dependencies = {'nvim-lua/plenary.nvim'},
        config = function()
            require('crates').setup({
                null_ls = {enabled = true, name = 'crates.nvim'}
            })
        end
    }
}
