let $CACHE = expand('~/.cache')

if !isdirectory($CACHE)
  call mkdir($CACHE, 'p')
endif

if &runtimepath !~# '/dein.vim'
  let s:dein_dir = fnamemodify('dein.vim', ':p')
  if !isdirectory(s:dein_dir)
    let s:dein_dir = $CACHE .. '/dein/repos/github.com/Shougo/dein.vim'
    if !isdirectory(s:dein_dir)
      execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
    endif
  endif
  execute 'set runtimepath^=' .. substitute(
        \ fnamemodify(s:dein_dir, ':p') , '[/\\]$', '', '')
endif


"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
let g:dein#install_github_api_token = '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'
" Required:
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:

  call dein#add('tpope/vim-surround')
  call dein#add('nvim-treesitter/nvim-treesitter', { 'merged': 0 })

  call dein#add('vifm/vifm.vim')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('mattn/emmet-vim')
  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('tpope/vim-fugitive')
  call dein#add('lewis6991/gitsigns.nvim')
  call dein#add('mileszs/ack.vim')
  call dein#add('thinca/vim-qfreplace')

  " call dein#add('williamboman/mason.nvim')
  " call dein#add('williamboman/mason-lspconfig.nvim')
  " call dein#add('neovim/nvim-lspconfig')
  
  " call dein#add('hrsh7th/nvim-cmp') " --補完エンジン本体
  " call dein#add('hrsh7th/cmp-nvim-lsp') " --LSPを補完ソースに
  " call dein#add('hrsh7th/cmp-buffer') "　--bufferを補完ソースに
  " call dein#add('hrsh7th/cmp-path')  " --pathを補完ソースに
  " call dein#add('hrsh7th/vim-vsnip') " --スニペットエンジン
  " call dein#add('hrsh7th/cmp-vsnip') " --スニペットを補完ソースに
  " call dein#add('mfussenegger/nvim-lint') " --補完エンジン本体

  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release', 'build': 'npm ci'})
  call dein#add('antoinemadec/coc-fzf')
  call dein#add('digitaltoad/vim-pug')
  call dein#add('christoomey/vim-tmux-navigator')

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


