return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        ft = {
            "lua", "sh", "bash", "python", "c", "cpp", "tex", "yaml", "bib",
            "gitcommit", "markdown", "plaintex", "rust", "javascript",
            "typescript", "javascriptreact", "typescriptreact",
            "javascript.jsx", "typescript.tsx", "html"
        },
        dependencies = {'hrsh7th/cmp-nvim-lsp', 'folke/neodev.nvim'},
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('USerLspConfig', {}),
                callback = function(ev)
                    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    local opts = {buffer = ev.buf}
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,
                                   opts)
                    vim.keymap.set('n', '<leader>D',
                                   vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                end
            })

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require('lspconfig')

            -- servers that don't need explicit extra configuration
            local servers = {
                'bashls', 'docker_compose_language_service', 'ltex',
                'rust_analyzer', 'tsserver', 'html'
            }

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {capabilities = capabilities}
            end

            local clangd_capabilities =
                require('cmp_nvim_lsp').default_capabilities()
            clangd_capabilities.offsetEncoding = "utf-8"
            lspconfig['clangd'].setup {capabilities = clangd_capabilities}

            -- setup neodev for Lua language server
            require('neodev').setup({
                library = {
                    enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                    -- these settings will be used for your Neovim config directory
                    runtime = true, -- runtime path
                    types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                    plugins = true -- installed opt or start plugins in packpath
                    -- you can also specify the list of plugins to make available as a workspace library
                    -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
                },
                setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
                -- for your Neovim config directory, the config.library settings will be used as is
                -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
                -- for any other directory, config.library.enabled will be set to false
                override = function(root_dir, options) end,
                -- With lspconfig, Neodev will automatically setup your lua-language-server
                -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
                -- in your lsp start options
                lspconfig = true,
                -- much faster, but needs a recent built of lua-language-server
                -- needs lua-language-server >= 3.6.0
                pathStrict = true
            })

            require("neodev").setup({
                library = {plugins = {"neotest"}, types = true}
            })

            -- servers that do need more than the default configuration
            lspconfig['lua_ls'].setup {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT'
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {'vim'}
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {enable = false}
                    }
                }
            }

            lspconfig['pylsp'].setup {
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                ignore = {'W391'},
                                maxLineLength = 88
                            }
                        }
                    }
                }
            }
        end
    }, {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {
            'saadparwaiz1/cmp_luasnip', 'L3MON4D3/LuaSnip',
            'onsails/lspkind.nvim', 'rafamadriz/friendly-snippets'
        },
        config = function()
            local luasnip = require('luasnip')

            local cmp = require('cmp')
            local lspkind = require('lspkind')

            require("luasnip/loaders/from_vscode").lazy_load()

            cmp.setup({
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol', -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function(entry, vim_item)
                            return vim_item
                        end
                    })
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
                    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
                    -- C-b (back) C-f (forward) for snippet placeholder navigation.
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true
                    }
                    -- ['<Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_next_item()
                    --     elseif luasnip.expand_or_jumpable() then
                    --         luasnip.expand_or_jump()
                    --     else
                    --         fallback()
                    --     end
                    -- end, {'i', 's'})
                    -- ['<S-Tab>'] = cmp.mapping(function(fallback)
                    --     if cmp.visible() then
                    --         cmp.select_prev_item()
                    --     elseif luasnip.jumpable(-1) then
                    --         luasnip.jump(-1)
                    --     else
                    --         fallback()
                    --     end
                    -- end, {'i', 's'})
                }),
                sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}}
            })
        end
    }, {
        'ray-x/lsp_signature.nvim',
        event = 'BufEnter',
        config = function()
            require('lsp_signature').setup {
                debug = false, -- set to true to enable debug logging
                log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log", -- log dir when debug is on
                -- default is  ~/.cache/nvim/lsp_signature.log
                verbose = false, -- show debug line number

                bind = true, -- This is mandatory, otherwise border config won't get registered.
                -- If you want to hook lspsaga or other signature handler, pls set to false
                doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
                -- set to 0 if you DO NOT want any API comments be shown
                -- This setting only take effect in insert mode, it does not affect signature help in normal
                -- mode, 10 by default

                max_height = 12, -- max height of signature floating_window
                max_width = 80, -- max_width of signature floating_window
                noice = false, -- set to true if you using noice to render markdown
                wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long

                floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

                floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
                -- will set to true when fully tested, set to false will use whichever side has more space
                -- this setting will be helpful if you do not want the PUM and floating win overlap

                floating_window_off_x = 1, -- adjust float windows x position.
                -- can be either a number or function
                floating_window_off_y = 0, -- adjust float windows y position. e.g -2 move window up 2 lines; 2 move down 2 lines
                -- can be either number or function, see examples

                close_timeout = 4000, -- close floating window after ms when laster parameter is entered
                fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
                hint_enable = true, -- virtual hint enable
                hint_prefix = "󰏚 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
                hint_scheme = "String",
                hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
                handler_opts = {
                    border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
                },

                always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

                auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
                extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
                zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

                padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc

                transparency = nil, -- disabled by default, allow floating win transparent value 1~100
                shadow_blend = 36, -- if you using shadow as border use this set the opacity
                shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
                timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
                toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'

                select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
                move_cursor_key = nil -- imap, use nvim_set_current_win to move cursor between current win and floating
            }
        end
    }
}
