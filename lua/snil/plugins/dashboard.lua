return {
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                --                theme = 'hyper' --  theme is doom and hyper default is hyper
                --                config = {
                --                  shortcut = {
                --                    -- action can be a function type
                --                    { desc = string, group = 'highlight group', key = 'shortcut key', action = 'action when you press key' },
                --                  },
                --                  packages = { enable = true }, -- show how many plugins neovim loaded
                --                  -- limit how many projects list, action when you press key or enter it will run this action.
                --                  project = { limit = 8, icon = 'your icon', label = '', action = 'Telescope find_files cwd=' },
                --                  mru = { limit = 10, icon = 'your icon', label = '', },
                --                  footer = {}, -- footer
                --                }
                --                hide = {
                --                  statusline    -- hide statusline default is true
                --                  tabline       -- hide the tabline
                --                  winbar        -- hide winbar
                --                },
                --                preview = {
                --                  command       -- preview command
                --                  file_path     -- preview file path
                --                  file_height   -- preview file height
                --                  file_width    -- preview file width
                --                },
            }
        end,
        dependencies = {{'nvim-tree/nvim-web-devicons'}}
    }
}
