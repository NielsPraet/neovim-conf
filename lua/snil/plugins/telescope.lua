return {
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = {'nvim-lua/plenary.nvim'},
        tag = "0.1.1",
        keys = {
            {'<leader>ff', '<cmd>Telescope find_files<cr>'},
            {'<leader>fg', '<cmd>Telescope live_grep<cr>'},
            {'<leader>fh', '<cmd>Telescope help_tags<cr>'},
            {'gr', function()
                require('telescope.builtin').lsp_references()
            end},
            {
                'gi',
                function()
                    require('telescope.builtin').lsp_implementations()
                end
            }
        }
    }, {
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim', 'nvim-tree/nvim-web-devicons'
        },
        keys = {
            {'<leader>fb', "<cmd>Telescope file_browser<cr>", noremap = true}
        },
        config = function()
            require('telescope').setup()

            require("telescope").load_extension("file_browser")
        end
    }
}
