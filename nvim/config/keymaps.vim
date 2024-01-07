cnoreabbrev Ack Ack!
nnoremap <Leader>a :Gcd <bar> Ack!<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:ack_qhandler = "botright copen 30"
endif

nmap <ESC><ESC> :nohlsearch<CR>
inoremap jk <ESC>
" 縦分割版gf
nnoremap gs :vertical wincmd f<CR>
nnoremap gn <C-w>gf
noremap <C-h> <C-w>W
noremap <C-l> <C-w>w
noremap <Leader>Q :cprevious<CR>
noremap <Leader>q :cnext<CR>
noremap <Leader>L :lp<CR>
noremap <Leader>l :lne<CR>
noremap <Leader>z <C-w>T<CR>
noremap j gj
noremap gl gt
noremap gh gT
noremap tn :tabnew<CR>
noremap k gk
noremap 0 g0
tnoremap <silent> <ESC> <C-\><C-n>

