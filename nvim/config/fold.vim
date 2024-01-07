
lua <<EOF

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

EOF

set foldtext=v:lua.vim.treesitter.foldtext()
