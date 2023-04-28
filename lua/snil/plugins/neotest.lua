return {
    {
        'nvim-neotest/neotest',
        dependencies = {
            'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter',
            'antoinemadec/FixCursorHold.nvim', "nvim-neotest/neotest-python",
            "rouge8/neotest-rust"
        },
        ft = {'python', 'rust'},
        keys = {
            {'<Leader>tf', function() require('neotest').run.run() end}, {
                '<Leader>tF',
                function()
                    require('neotest').run.run(vim.fn.expand('%'))
                end
            }, {
                '<Leader>tdf',
                function()
                    require('neotest').run.run({strategy = "dap"})
                end
            }, {'<Leader>ts', function()
                require('neotest').run.stop()
            end}
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        -- Extra arguments for nvim-dap configuration
                        -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
                        dap = {justMyCode = false},
                        -- Command line arguments for runner
                        -- Can also be a function to return dynamic values
                        args = {"--log-level", "DEBUG"},
                        -- Runner to use. Will use pytest if available by default.
                        -- Can be a function to return dynamic value.
                        runner = "pytest",
                        -- Custom python path for the runner.
                        -- Can be a string or a list of strings.
                        -- Can also be a function to return dynamic value.
                        -- If not provided, the path will be inferred by checking for
                        -- virtual envs in the local directory and for Pipenev/Poetry configs

                        --  python = ".venv/bin/python",

                        -- Returns if a given file path is a test file.
                        -- NB: This function is called a lot so don't perform any heavy tasks within it.
                        is_test_file = function(file_path) end
                    }), require("neotest-rust") {args = {"--no-capture"}}
                }
            })
        end
    }
}
