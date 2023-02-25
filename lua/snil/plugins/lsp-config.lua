return {
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        ft = {"lua", "sh", "bash", "python"},
        dependencies = {'hrsh7th/cmp-nvim-lsp'},
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lspconfig = require('lspconfig')

            -- servers that don't need explicit extra configuration
            local servers = {'bashls'}

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {capabilities = capabilities}
            end

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
                                maxLineLength = 100
                            }
                        }
                    }
                }
            }
        end

    }, {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        dependencies = {'saadparwaiz1/cmp_luasnip', 'L3MON4D3/LuaSnip'},
        config = function()
            local luasnip = require('luasnip')

            local cmp = require('cmp')

            cmp.setup({
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
                    },
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, {'i', 's'}),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, {'i', 's'})
                }),
                sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}}
            })
        end
    }
}
