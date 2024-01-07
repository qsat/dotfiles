let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25

"augroup netrw
"  autocmd!
"  autocmd FileType netrw map <buffer> l <Return>
"  autocmd FileType netrw map <buffer> h -
"  autocmd FileType netrw map <buffer> q :bd<Return>
"  autocmd FileType netrw map <buffer> <C-h> <C-w>W
"  autocmd FileType netrw map <buffer> <C-l> <C-w>w
"  autocmd FileType netrw hi netrwMarkFile cterm=NONE ctermfg=140 ctermbg=234 guifg=234 guibg=234
"augroup END
"
" vifm
let g:vifm_replace_netrw = 1
let g:vifm_embed_term = 1
