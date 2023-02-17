vim.opt.nu = true -- print the line number in front of each line
vim.opt.relativenumber = true -- show relative line number in front of each line

vim.opt.tabstop = 4 -- number of spaces that <Tab> in file uses
vim.opt.softtabstop = 4 -- number of spaces that <Tab> uses while editing
vim.opt.shiftwidth = 4 -- number of spaces to use for (auto)indent step
vim.opt.expandtab = true -- use spaces when <Tab> is inserted
vim.opt.hlsearch = false -- highlight matches with last search pattern
vim.opt.incsearch = true -- highlight match while typing search pattern

vim.opt.smartindent = true -- smart autoindenting for C programs

vim.opt.wrap = false -- long lines wrap and continue on the next line

vim.opt.scrolloff = 8 -- minimum nr. of lines above and below cursor
vim.opt.splitbelow = true -- new window from split is below the current one
vim.opt.splitright = true -- new window is put right to the current one
vim.opt.hidden = true -- don't unload the buffer when it is abandoned
vim.opt.termguicolors = true -- enables 24-bit RGB color in the TUI.

vim.g.mapleader = " " -- value of <leader> key

vim.opt.timeoutlen = 500

vim.o.updatetime = 750
vim.wo.signcolumn = 'yes'
vim.o.completeopt = 'menuone,noselect'

vim.o.swapfile = false

vim.opt.colorcolumn = ""
