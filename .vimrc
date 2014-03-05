set background=dark
syntax on

colorscheme iceberg
"colorscheme hybrid
"colorscheme jellybeans

let loaded_matchparen = 1
set autoread
set nu
set ruler
set cursorline
"set cursorcolumn
set expandtab
set shiftwidth=2
"set nowrap
set hlsearch
set tabstop=2
"set list
set softtabstop=2
set autoindent
set smartindent
set noswapfile
set nobackup
set noequalalways

set clipboard=unnamed

"------------------------------------------------
" neocompleteを使う

" neocomplete用設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete_auto_completion_start_length = 3

if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns._ = '\h\w*'

inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"


source $VIMRUNTIME/macros/matchit.vim

highlight LineNr ctermfg=238 ctermbg=none
highlight CursorLine cterm=none ctermbg=238 guibg=black
highlight CursorColumn cterm=none ctermbg=238 guibg=black
highlight Visual cterm=none ctermbg=240 guibg=black

" カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END

"statusline
set laststatus=2 
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}[%{&fileencoding}:%Y:#\%03.3b(0x\%02.2B):%1l/%L]
highlight statusline term=NONE cterm=NONE guifg=black ctermfg=black ctermbg=255
highlight StatusLineNC term=NONE cterm=NONE guifg=black ctermfg=black ctermbg=240

"scss
au BufRead,BufNewFile *.scss set filetype=scss

"actionscript
autocmd! BufNewFile,BufRead *.as setlocal filetype=actionscript

"coffeescript
let g:quickrun_config = {}
let g:quickrun_config={'*': {'split': 'vertical'}}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}

"zen-coding
"let g:user_zen_leader_key = '<C-y>'
let g:emmet_html5 = 0

"paste mode
set pastetoggle=<C-e>

"neobundle
set nocompatible               " Be iMproved
 filetype off                   " Required!

 if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 call neobundle#rc(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 "NeoBundle 'Shougo/neobundle.vim'

 " Recommended to install
 " After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
 NeoBundle 'Shougo/vimshell'
 NeoBundle 'Shougo/vimproc'

 " My Bundles here:
 "
 " Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle "Shougo/unite-outline"
NeoBundle 'ActionScript-3-Omnicomplete'
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'violetyk/cake.vim'
NeoBundle 'oppara/vim-unite-cake'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'tpope/vim-vividchalk'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'Gist.vim'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'http://github.com/kchmck/vim-coffee-script'
NeoBundle 'https://github.com/mattn/emmet-vim.git'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle "sakuraiyuta/commentout.vim"
NeoBundle "rhysd/clever-f.vim"
NeoBundle 'majutsushi/tagbar'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'git://github.com/vim-scripts/actionscript.vim--Leider.git'


if has('python') && executable('npm')
  NeoBundleLazy 'marijnh/tern_for_vim', {
        \ 'build' : 'npm install',
        \ 'autoload' : {
        \   'functions': ['tern#Complete', 'tern#Enable'],
        \   'filetypes' : 'javascript'
        \ }}
endif

filetype plugin indent on     " Required!
 "
 " Brief help
 " :NeoBundleList          - list configured bundles
 " :NeoBundleInstall(!)    - install(update) bundles
 " :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

 " Installation check.
 if neobundle#exists_not_installed_bundles()
   echomsg 'Not installed bundles : ' .
         \ string(neobundle#get_not_installed_bundle_names())
   echomsg 'Please execute ":NeoBundleInstall" command.'
   "finish
 endif

""" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
let g:unite_winwidth = 40 
let g:unite_winheight = 20
let g:unite_source_history_yank_enable = 1
" レジスタ一覧
" 最近使用したファイル一覧
nnoremap <silent> <Space>m :<C-u>Unite file_mru directory_mru bookmark<CR>
nnoremap <silent> vs :<C-u>VimShell<CR>
nnoremap <silent> vp :<C-u>VimShellPop<CR>
nnoremap <silent> <Space>h :<C-u>Unite vimshell/history<CR>
nnoremap <silent> <Space>n :<C-u>Unite bookmark<CR>
nnoremap <silent> <Space>r :<C-u>Unite history/yank<CR>
nnoremap <silent> <Space>g :<C-u>Unite grep<CR>
nnoremap <silent> <Space>G :<C-u>Unite grep:%::<C-R>=expand("<cword>")<CR><CR>
" 行検索
nnoremap <silent> <Space>l :<C-u>Unite line<CR>
nnoremap <silent> <Space>L :<C-u>UniteWithCursorWord line<CR>
" outline
nnoremap <silent> <Space>o :<C-u>Unite -no-quit -keep-focus -vertical outline<CR>

nnoremap <silent> <Space>um :<C-u>Unite mark<CR>
nnoremap <silent> <Space>ul :<C-u>Unite locate<CR>
nnoremap <silent> <Space>uu :Unite -direction=botright -default-action=vimfiler directory_mru<CR>

nnoremap <silent> <Space>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Space>q :<C-u>Unite file_rec<CR>

" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=black ctermbg=136 cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

""" buffer 関連
"nmap <Space>b :ls<CR>:buffer 
nmap <Space>e :VimFilerBufferDir -project<CR>
nmap <Space>v :vsplit<CR><C-w><C-w>:ls<CR>:buffer
nmap <Space>, :only<CR>

"""ヤジルシキー無効
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
inoremap <UP> <Nop>
inoremap <Down> <Nop>
inoremap <RIGHT> <Nop>
inoremap <LEFT> <Nop>
inoremap <c-a> <END>
inoremap <c-0> <HOME>

let g:vimfiler_as_default_explorer = 1

set ambiwidth=double

set tabline=%!MyTabLine()

function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '
  endfor

  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'

  " right-align the label to close the current tab page
  if tabpagenr('$') > 1 
    let s .= '%=%#TabLine#%999Xclose'
  endif

  return s
endfunction

function MyTabLabel(n)
  let buflist = tabpagebuflist(a:n)
  let winnr = tabpagewinnr(a:n)
  let label =  bufname(buflist[winnr - 1]) 
  return fnamemodify(label, ":t") 
endfunction

" for Fugitive {{{
nnoremap <Space>gd :<C-u>Gdiff<Enter>
nnoremap <Space>gs :<C-u>Gstatus<Enter>
nnoremap <Space>gl :<C-u>Gitv<Enter>
nnoremap <Space>ga :<C-u>Gwrite<Enter>
nnoremap <Space>gc :<C-u>Gcommit<Enter>
nnoremap <Space>gC :<C-u>Git commit --amend<Enter>
nnoremap <Space>gb :<C-u>Gblame<Enter>
" }}}


nnoremap <Space>c :<C-u>setlocal cursorcolumn!<CR>
nnoremap <Space>w :<C-u>setlocal wrap!<CR>


"gitv config

autocmd FileType git :setlocal foldlevel=99

" 改行コードの自動認識
set fileformats=unix,dos,mac

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" tagsジャンプの時に複数ある時は一覧表示                                        
nnoremap <C-]> g<C-]>
" tagbar
nmap <F5> :TagbarToggle<CR>

" 縦分割版gf
nnoremap gs :vertical wincmd f<CR>

"Jade
autocmd BufNewFile,BufRead *.jade  setf jade
autocmd BufNewFile,BufRead *.jade  set tabstop=2 shiftwidth=2 expandtab
let g:quickrun_config['jade']={'command': 'jade', 'cmdopt': '-P', 'exec': ['%c -P < %s']}
