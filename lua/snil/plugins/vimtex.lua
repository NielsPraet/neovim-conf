return {
    {
        'lervag/vimtex',
        ft = {'tex'},
        config = function()
            local g = vim.g
            -- Viewer options: One may configure the viewer either by specifying a built-in
            -- viewer method:
            g["vimtex_view_method"] = "zathura"

            -- Or with a generic interface:
            g["vimtex_view_general_viewer"] = "okular"
            g["vimtex_view_general_options"] =
                "--unique file:@pdf\\#src:@line@tex"

            -- VimTeX uses latexmk as the default compiler backend. If you use it, which is
            -- strongly recommended, you probably don't need to configure anything. If you
            -- want another compiler backend, you can change it as follows. The list of
            -- supported backends and further explanation is provided in the documentation,
            -- see ":help vimtex-compiler".
            -- g['vimtex_compiler_method'] = 'latexrun'

            -- spell check
            -- vim.cmd([[autocmd FileType tex setlocal spell]])
            -- Turn on spelling only for that buffer (not needed anymore with ltex-ls)
            -- vim.api.nvim_create_autocmd("FileType", {
            -- 	-- command = "nmap <buffer> <A-j> )",
            -- 	pattern = { "tex" },
            -- 	callback = function()
            -- 		vim.opt_local.spell = true
            -- 		-- vim.cmd([[setlocal dictionary+=/usr/share/dict/words]])
            -- 		-- vim.cmd([[dictionary+=/usr/share/dict/dutch]])
            -- 	end,
        end
    }
}
