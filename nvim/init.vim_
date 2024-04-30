syntax on

set encoding=utf-8

set hidden
let mapleader = "\<Space>"
let loaded_matchparen = 1

set cmdheight=2
set updatetime=300
set shortmess+=c
set noundofile
set breakindent
set backspace=indent,eol,start
set autoread
set nonumber
set expandtab
set shiftwidth=2
set hlsearch
set tabstop=2
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
set notitle

if !exists('g:vscode')

  set list
  set autochdir
  set clipboard=unnamed
  set signcolumn=yes:1
  set fileformats=unix,dos,mac
  set suffixesadd=.js,.jsx

  runtime config/plugins.vim
  runtime config/gitsigns.vim
  runtime config/colors.vim
  runtime config/vifm.vim
  runtime config/commands.vim
  runtime config/coc.vim
  runtime config/fzf.vim
  runtime config/statusline.vim
  runtime config/treesitter.vim
  runtime config/keymaps.vim
  " runtime config/fold.vim
  " runtime config/lsp.vim
  " runtime config/completion.vim
  " runtime config/lint.vim

  " □とか○の文字があってもカーソル位置がずれないようにする
  if exists('&ambiwidth')
    set ambiwidth=double
  endif
endif

