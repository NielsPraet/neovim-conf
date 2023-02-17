return {
    {
        'mfussenegger/nvim-dap',
        keys = {
            { '<F5>', function() require('dap').continue() end, desc = 'continue' },
            { '<F9>', function() require('dap').step_back() end, desc = 'step back' },
            { '<F10>', function() require('dap').step_over() end, desc = 'step over function call' },
            { '<F11>', function() require('dap').step_into() end, desc = 'step into function call' },
            { '<F12>', function() require('dap').step_out() end, desc = 'step out of function call' },
            { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'toggle a breakpoint' },
            { '<leader>dB', function() require('dap').toggle_breakpoint() end, desc = 'set a breakpoint' },
            { '<leader>dbl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = 'set a log point' },
            { '<leader>dbx', function() require('dap').clear_breakpoints() end, desc = 'clear all breakpoints' },
            { '<leader>dbl', function() require('dap').list_breakpoints() end, desc = 'list all breakpoints'},
            { '<leader>dx', function() require('dap').terminate() end, desc = 'terminate debug session' },
            { '<leader>dr', function() require('dap').restart() end, desc = 'restart debug session' },
            { '<leader>dl', function() require('dap').run_last() end, desc = 'rerun last debug configuration' },
            { '<leader>dc', function() require('dap').run_to_cursor() end, desc = 'run debug session until cursor location' },
            { '<leader>dp', function() require('dap').pause() end, desc = 'pause a debug session' },
        },
        config = function ()
            local sign = vim.fn.sign_define
            local dap = require('dap')

            sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
            sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

            --=== Adapters ====--
            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/bin/lldb-vscode',
                name = 'lldb'
            }

            --=== configurations ===--
            dap.configurations.cpp = {
                name = 'Launch',
                type = 'lldb',
                request = 'launch',
                program = function()
                    return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = '${workspaceFolder}',
                stopOnEntry = false,
                args = {}
            }

            dap.configurations.c = dap.configurations.cpp;
            dap.configurations.rust = dap.configurations.cpp;

        end
    },
    {
        'mfussenegger/nvim-dap-python',
        dependencies = {
            'mfussenegger/nvim-dap',
        },
        keys = {
            {'<leader>dn', function() require('dap-python').test_method() end, desc = 'test method'},
            {'<leader>df', function() require('dap-python').test_class() end, desc = 'test class'},
            {'<leader>ds', function() require('dap-python').debug_selection() end, desc = 'debug selection'},
        },
        ft = "python",
        config = function()
            require('dap-python').setup('~/.virtualenvs/debugpy/bin/python')
        end
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            'mfussenegger/nvim-dap',
            'theHamsta/nvim-dap-virtual-text'
        },
        keys = {
            {'<leader>dui', function() require('dapui').toggle() end, desc = 'toggle debug ui'},
        },
        config = function()
            require("dapui").setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                mappings = {
                    -- Use a table to apply multiple mappings
                    expand = { "<CR>", "<2-LeftMouse>" },
                    open = "o",
                    remove = "d",
                    edit = "e",
                    repl = "r",
                    toggle = "t",
                },
                -- Use this to override mappings for specific elements
                element_mappings = {
                    -- Example:
                    -- stacks = {
                    --   open = "<CR>",
                    --   expand = "o",
                    -- }
                },
                -- Expand lines larger than the window
                -- Requires >= 0.7
                expand_lines = vim.fn.has("nvim-0.7") == 1,
                -- Layouts define sections of the screen to place windows.
                -- The position can be "left", "right", "top" or "bottom".
                -- The size specifies the height/width depending on position. It can be an Int
                -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
                -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
                -- Elements are the elements shown in the layout (in order).
                -- Layouts are opened in order so that earlier layouts take priority in window sizing.
                layouts = {
                    {
                        elements = {
                            -- Elements can be strings or table with id and size keys.
                            -- order is inverse here
                            { id = "breakpoints", size = 0.15 },
                            { id = "watches", size = 0.20 },
                            { id = "stacks", size = 0.20 },
                            { id = "scopes", size = 0.45 },
                        },
                        size = 40, -- 40 columns
                        position = "left",
                    },
                    {
                        elements = {
                            "console",
                            "repl",
                        },
                        size = 0.25, -- 25% of total lines
                        position = "bottom",
                    },
                },
                controls = {
                    -- Requires Neovim nightly (or 0.8 when released)
                    enabled = true,
                    -- Display controls in this element
                    element = "repl",
                    icons = {
                        pause = "",
                        play = "",
                        step_into = "",
                        step_over = "",
                        step_out = "",
                        step_back = "",
                        run_last = "↻",
                        terminate = "□",
                    },
                },
                floating = {
                    max_height = nil, -- These can be integers or a float between 0 and 1.
                    max_width = nil, -- Floats will be treated as percentage of your screen.
                    border = "single", -- Border style. Can be "single", "double" or "rounded"
                    mappings = {
                        close = { "q", "<Esc>" },
                    },
                },
                windows = { indent = 1 },
                render = {
                    max_type_length = nil, -- Can be integer or nil.
                    max_value_lines = 100, -- Can be integer or nil.
                }
            })

            require("nvim-dap-virtual-text").setup {
                enabled = true, -- enable this plugin (the default)
                enabled_commands = false, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                show_stop_reason = true, -- show stop reason when stopped for exceptions
                commented = false, -- prefix virtual text with comment string
                only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
                all_references = false, -- show virtual text on all all references of the variable (not only definitions)
                filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
                -- experimental features:
                virt_text_pos = 'eol', -- position of virtual text, see `:h nvim_buf_set_extmark()`
                all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
                virt_text_win_col = nil -- position the virtual text at a fixed window column (starting from the first text column) ,
                -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
            }

            local dap, dapui = require("dap"), require("dapui")
            local dapvirt = require("nvim-dap-virtual-text")
            dap.listeners.after.event_initialized["dapui_config"] = function()
              dapui.open()
              dapvirt.enable()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
              dapui.close()
              dapvirt.disable()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
              dapui.close()
              dapvirt.disable()
            end
        end
    }
}
