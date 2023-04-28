return {
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = {'nvim-lua/plenary.nvim'},
        ft = {
            'lua', 'make', 'cmake', 'javascript', 'javascriptreact',
            'typescript', 'typescriptreact', 'c', 'cpp', 'python', 'json',
            'sass', 'css', 'scss', 'less', 'yaml', 'zsh', 'rust', 'tex',
            'javascript.jsx', 'typescript.tsx', 'html'
        },
        config = function()
            local null_ls = require('null-ls')
            -- code action sources
            local code_actions = null_ls.builtins.code_actions

            -- diagnostic sources
            local diagnostics = null_ls.builtins.diagnostics

            -- formatting sources
            local formatting = null_ls.builtins.formatting

            -- completion sources
            local completion = null_ls.builtins.completion

            local sources = {
                -- code actions
                code_actions.eslint_d, code_actions.gitsigns, -- diagnostics
                diagnostics.checkmake, diagnostics.cmake_lint,
                diagnostics.cppcheck, diagnostics.dotenv_linter,
                diagnostics.editorconfig_checker, diagnostics.eslint_d,
                diagnostics.ruff, diagnostics.jsonlint, diagnostics.stylelint,
                diagnostics.tsc, diagnostics.yamllint, diagnostics.zsh,
                diagnostics.chktex, -- formatting
                formatting.beautysh, formatting.clang_format,
                formatting.cmake_format, formatting.eslint_d,
                formatting.fixjson, formatting.lua_format, formatting.prettierd,
                formatting.ruff, formatting.rustfmt, -- completion
                completion.luasnip
            }

            local augroup = vim.api.nvim_create_augroup('LspFormatting', {})

            null_ls.setup {
                sources = sources,
                -- set up autoformatting on save
                on_attach = function(client, bufnr)
                    if client.supports_method('textDocument/formatting') then
                        vim.api.nvim_clear_autocmds({
                            group = augroup,
                            buffer = bufnr
                        })
                        vim.api.nvim_create_autocmd('BufWritePre', {
                            group = augroup,
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({bufnr = bufnr})
                            end
                        })
                    end
                end
            }
        end
    }
}
