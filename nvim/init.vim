syntax on

"set termguicolors
set hidden
let mapleader = "\<Space>"

let loaded_matchparen = 1
set noundofile
set breakindent
set backspace=indent,eol,start
set autoread
set nu
set ruler
" set cursorline
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
set statusline=2
set autochdir

set clipboard=unnamed

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
 call dein#add('Shougo/deoplete.nvim', { 'on_i': 1 })
 call dein#add('ctrlpvim/ctrlp.vim')
 call dein#add('thinca/vim-qfreplace')
 call dein#add('mileszs/ack.vim')

 call dein#add('w0rp/ale')
 call dein#add('pangloss/vim-javascript')
 call dein#add('MaxMEllon/vim-jsx-pretty')


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

nmap <Leader><Leader> V
nmap <ESC><ESC> :nohlsearch<CR>
inoremap jj <ESC>

noremap <S-TAB> <C-w>W
noremap <TAB> <C-w>w
noremap <Leader>n :browse oldfiles<CR>
noremap <Leader>b :b 
noremap <Leader>e :e .<CR>
noremap <Leader>t :terminal<CR>
noremap <Leader>Q :cprevious<CR>
noremap <Leader>q :cnext<CR>

noremap j gj
noremap k gk
noremap 0 g0

tnoremap <silent> <ESC> <C-\><C-n>

" 改行コードの自動認識
set fileformats=unix,dos,mac

" 補完候補の選択
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" CtrlP
noremap <Leader>m :CtrlPMRUFiles<CR>
noremap <Leader>p :CtrlP<CR>

let g:ctrlp_map = '<Nop>'
let g:ctrlp_lazy_update = 1
let g:ctrlp_extensions = ['tag', 'quickfix', 'dir', 'line', 'mixed']
let g:ctrlp_match_window = 'top,order:ttb,max:20'
let g:ctrlp_cmd = 'CtrlPMRU'
let g:fuzzy_ignore = "*.class,*.pyc,*.log,*.o"

if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
  let g:ackprg = 'ag --vimgrep'
  let g:ack_qhandler = "botright copen 30"
endif

cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

" Use ALE
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_open_list = 1

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" Netrw
let g:netrw_browse_split = 4
let g:netrw_altv = 1

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  noremap <buffer> h -
  noremap <buffer> l <Enter>
endfunction

" ファイル名表示
set statusline=%F
" 変更チェック表示
set statusline+=%m
" 読み込み専用かどうか表示
set statusline+=%r
" ヘルプページなら[HELP]と表示
set statusline+=%h
" これ以降は右寄せ表示
set statusline+=%=
"set statusline+=[%{ALEGetStatusLine()]
"ファイルタイプ表示
set statusline+=%y
" file encoding
set statusline+=[%{&fileencoding}]
" 現在行数/全行数
set statusline+=%l/%L
" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

colorscheme iceberg
