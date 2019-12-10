syntax on

set hidden
let mapleader = "\<Space>"
let loaded_matchparen = 1
set noundofile
set breakindent
set backspace=indent,eol,start
set autoread
set nonumber
set expandtab
set shiftwidth=2
set hlsearch
set tabstop=2
set list
set softtabstop=2
set autoindent
set smartindent
set noswapfile
set nobackup
set noequalalways
set pumheight=10
set display=lastline
set showmatch
set incsearch
set matchtime=1
set statusline=''
set autochdir
set notitle
set clipboard=unnamed
set fileformats=unix,dos,mac
set suffixesadd=.js,.jsx

let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

augroup netrw
  autocmd!
  autocmd FileType netrw map <buffer> l <Return>
  autocmd FileType netrw map <buffer> h -
  autocmd FileType netrw map <buffer> q :bd<Return>
augroup END

" Use deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#enable_camel_case = 0
let g:deoplete#enable_ignore_case = 0
let g:deoplete#enable_refresh_always = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#file#enable_buffer_path = 1
let g:deoplete#max_list = 10000

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
 call dein#add('tpope/vim-surround')
 call dein#add('HerringtonDarkholme/yats.vim')
 call dein#add('autozimu/LanguageClient-neovim', {'rev': 'next', 'build': 'bash install.sh'})
 call dein#add('Shougo/deoplete.nvim')
 call dein#add('thinca/vim-qfreplace')
 call dein#add('mileszs/ack.vim')
 call dein#add('w0rp/ale')
 call dein#add('pangloss/vim-javascript')
 call dein#add('styled-components/vim-styled-components', {'on_ft': ['javascript', 'javascript.jsx', 'typescript', 'typescript.jsx']})
 call dein#add('MaxMEllon/vim-jsx-pretty')
 call dein#add('tpope/vim-fugitive')
 call dein#add('GutenYe/json5.vim')
 call dein#add('mattn/emmet-vim')
 call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
 call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

nmap <ESC><ESC> :nohlsearch<CR>
inoremap jj <ESC>
inoremap kk <ESC>

" 縦分割版gf
nnoremap gs :vertical wincmd f<CR>

noremap <C-h> <C-w>W
noremap <C-l> <C-w>w
noremap <Leader>Q :cprevious<CR>
noremap <Leader>q :cnext<CR>
noremap <Leader>L :lp<CR>
noremap <Leader>l :lne<CR>
noremap <Leader>z <C-w>T<CR>

noremap j gj
noremap k gk
noremap 0 g0

tnoremap <silent> <ESC> <C-\><C-n>

" fzf
noremap <Leader>b :Buffers<CR>
noremap <Leader>p :GFiles<CR>
noremap <Leader>m :History<CR>
noremap <Leader>h :BCommits<CR>
noremap <Leader>e :Files<CR>
" query, ag options, fzf#run options, fullscreen
autocmd VimEnter *
\ command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>, '', { 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' }, <bang>0)
autocmd! FileType fzf noremap <buffer> <ESC><ESC> :q<CR>

" 補完候補の選択
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

""AutoChangeDirectory
au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:ack_qhandler = "botright copen 30"
endif

" cnoreabbrev Ack Ack!
nnoremap <Leader>a :Gcd <bar> Ack!<Space>

autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufRead,BufNewFile *.tsx set filetype=typescript

" ALE
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
" let g:ale_sign_column_always = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_javascript_prettier_use_local_config = 1
let g:ale_fixers = {
\ 'javascript': ['eslint'],
\ 'typescript': ['eslint'],
\ 'json': ['prettier']
\ }
let g:ale_fix_on_save = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ 'typescript.tsx': ['javascript-typescript-stdio'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" ファイル名表示
set statusline=%f
" " 変更チェック表示
set statusline+=%m
" " 読み込み専用かどうか表示
set statusline+=%r
" " ヘルプページなら[HELP]と表示
" set statusline+=%h
" " これ以降は右寄せ表示
set statusline+=%=
" "set statusline+=[%{ALEGetStatusLine()]
" "ファイルタイプ表示
" set statusline+=%y
" " file encoding
" 現在行数/全行数
set statusline+=%c--%l/%L
" set statusline+=[%{&fileencoding}]
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

colorscheme iceberg

"hi StatusLine term=NONE cterm=NONE ctermfg=238 ctermbg=234 guifg=234 guibg=234
hi StatusLine cterm=NONE ctermfg=241 ctermbg=234 guifg=234 guibg=234
hi StatusLineNC ctermfg=234 ctermbg=232 guifg=234 guibg=234
hi StatusLineTerm term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234
hi StatusLineTermNC term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234

hi VertSplit cterm=NONE ctermfg=234 ctermbg=234 guibg=234 guifg=234

autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
