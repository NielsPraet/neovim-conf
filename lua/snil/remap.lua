local nnoremap = require("snil.keymap").nnoremap
local vnoremap = require("snil.keymap").vnoremap
local xnoremap = require("snil.keymap").xnoremap

-- move lines
nnoremap("<A-k>", "<cmd>m .-2<cr>")
nnoremap("<A-j>", "<cmd>m .+1<cr>")
nnoremap("<A-l>", ">>")
nnoremap("<A-h>", "<<")

vnoremap("<A-j>", ":m '>+1<CR>gv")
vnoremap("<A-k>", ":m '<-2<CR>gv")
vnoremap("<A-h>", ":<<CR>gv")
vnoremap("<A-l>", ":><CR>gv")

-- Smoother vertical movement
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- move blocks in visual mode
vnoremap("J", ":m '>+1<CR>gv=gv'")
vnoremap("K", ":m '<-2<CR>gv=gv'")

-- paste selection without setting clipboard to deleted selection
xnoremap("<leader>p", "\"_dP")

nnoremap("<leader>y", "\"+y")
nnoremap("<leader>y", "\"+y")
nnoremap("<leader>Y", "\"+Y")

nnoremap("<leader>p", "\"+p")
vnoremap("<leader>p", "\"+p")
nnoremap("<leader>P", "\"+P")

nnoremap("Q", "<nop>")

vim.keymap.set("n", "<leader>s",
    [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
