set background=dark
syntax on

autocmd ColorScheme * highlight Comment ctermfg=243 guifg=#888800

let mapleader = "\<Space>"

let loaded_matchparen = 1
set noundofile
set breakindent
set backspace=indent,eol,start
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
set pumheight=10
set display=lastline
set showmatch
set matchtime=1
set statusline=2

nnoremap Y y$

set clipboard=unnamed
"------------------------------------------------

nmap <Leader><Leader> V

" neocomplete用設定
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete_auto_completion_start_length = 3

" neocompleteを使う
let g:EclimCompletionMethod = 'omnifunc'


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

augroup Processing
  autocmd!
  autocmd BufNewFile *.pde NeoBundleSource vim-processing
  autocmd BufRead    *.pde NeoBundleSource vim-processing
augroup END


"scss
au BufRead,BufNewFile *.scss set filetype=scss

"actionscript
autocmd! BufNewFile,BufRead *.as setlocal filetype=actionscript

"coffeescript
let g:quickrun_config = {}
let g:quickrun_config={'*': {'split': 'vertical'}}
let g:quickrun_config['coffee'] = {'command' : 'coffee', 'exec' : ['%c -cbp %s']}
let g:quickrun_config['jade'] = {'command': 'jade', 'cmdopt': '-P', 'exec': ['%c -P < %s']}
let g:quickrun_config['swift'] = { 'command': 'xcrun', 'cmdopt': 'swift', 'exec': '%c %o %s'}

let g:quickrun_config.processing = {
\     'command': 'processing-java',
\     'exec': '%c --sketch=%s:p:h/ --output=/tmp/processing --run --force' }




"zen-coding
"let g:user_zen_leader_key = '<C-y>'
let g:emmet_html5 = 0

"paste mode
set pastetoggle=<F2>

"neobundle
set nocompatible               " Be iMproved
 filetype off                   " Required!

 if has('vim_starting')
   set runtimepath+=~/.vim/bundle/neobundle.vim/
 endif

 call neobundle#begin(expand('~/.vim/bundle/'))

 " Let NeoBundle manage NeoBundle
 "NeoBundle 'Shougo/neobundle.vim'

 " Recommended to install
 " After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
 NeoBundle 'Shougo/vimshell'
 NeoBundle 'Shougo/vimproc'

 " My Bundles here:
 " " Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle "Shougo/unite-outline"
NeoBundle 'ujihisa/unite-locate'
NeoBundle 'violetyk/cake.vim'
NeoBundle 'oppara/vim-unite-cake'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'tpope/vim-rails'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'gregsexton/gitv'
NeoBundle 'tacroe/unite-mark'
NeoBundle 'Gist.vim'
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'http://github.com/kchmck/vim-coffee-script'
NeoBundle 'https://github.com/mattn/emmet-vim.git'
NeoBundle 'wavded/vim-stylus'
NeoBundle "sakuraiyuta/commentout.vim"
NeoBundle "rhysd/clever-f.vim"
NeoBundle 'majutsushi/tagbar'
NeoBundle 'lukaszkorecki/CoffeeTags'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'cocopon/iceberg.vim'
NeoBundle 'djjcast/mirodark'
NeoBundle 'kakkyz81/evervim'
NeoBundle 'toyamarinyon/vim-swift'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle "sophacles/vim-processing"
NeoBundle 'raichoo/purescript-vim'
NeoBundle 'endel/actionscript.vim'
NeoBundle 'terryma/vim-expand-region'
"NeoBundleLazy 'ervandew/eclim', {'rev': '2.2.7','build': {'mac': 'ant -Declipse.home=/Applications/eclipse -Dvim.files='.escape(expand('~/.bundle/eclim'), '')}}
"autocmd FileType actionscript NeoBundleSource eclim
call neobundle#end()

filetype plugin indent on     " Required!

" Installation check.
NeoBundleCheck

""" unite.vim
" 入力モードで開始する
let g:unite_enable_start_insert=1
let g:unite_winwidth = 40 
let g:unite_winheight = 20
let g:unite_source_history_yank_enable = 1

""" vimshell
let g:vimshell_popup_command = 'vsplit'
" レジスタ一覧
" 最近使用したファイル一覧
nnoremap <silent> <Leader>m :<C-u>Unite file_mru directory_mru bookmark<CR>
nnoremap <silent> vs :<C-u>VimShellPop<CR>
nnoremap <silent> <Leader>h :<C-u>Unite vimshell/history<CR>
nnoremap <silent> <Leader>n :<C-u>Unite bookmark<CR>
nnoremap <silent> <Leader>r :<C-u>Unite history/yank<CR>
nnoremap <silent> <Leader>g :<C-u>Unite grep<CR>
nnoremap <silent> <Leader>G :<C-u>Unite grep:%::<C-R>=expand("<cword>")<CR><CR>
" 行検索
nnoremap <silent> <Leader>l :<C-u>Unite line<CR>
nnoremap <silent> <Leader>L :<C-u>UniteWithCursorWord line<CR>
" outline
" nnoremap <silent> <Space>o :<C-u>Unite -no-quit -keep-focus outline<CR>
nnoremap <silent> <Leader>o :<C-u>Unite -no-quit outline<CR>

nnoremap <silent> <Leader>um :<C-u>Unite mark<CR>
nnoremap <silent> <Leader>ul :<C-u>Unite locate<CR>
nnoremap <silent> <Leader>uu :Unite -direction=botright -default-action=vimfiler directory_mru<CR>

nnoremap <silent> <Leader>b :<C-u>Unite buffer<CR>
nnoremap <silent> <Leader>q :<C-u>Unite file_rec<CR>

" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-v> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified'] ]
      \ },
      \ 'inactive': {
      \   'left': [['fpath']]
      \ },
      \ 'component': {
      \   'fpath': '%F',
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ }

""" buffer 関連
"nmap <Space>b :ls<CR>:buffer 
noremap <S-TAB> <C-w>W
noremap <TAB> <C-w>w

" 補完候補の選択
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

nmap <Leader>p :VimFilerBufferDir -project<CR>
nmap <Leader>e :VimFilerBufferDir<CR>
nmap <Leader>v :VimFilerBufferDir -project -find -split -simple -winwidth=45 -toggle -no-quit<CR>
nmap <Leader>, :only<CR>
nmap <Leader>. :tabc<CR>

"""ヤジルシキー無効
noremap j gj
noremap k gk
noremap 0 g0

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


set ambiwidth=double

" CoffeeTags

if executable('coffeetags')
  let g:tagbar_type_coffee = {
    \ 'ctagsbin' : 'coffeetags',
    \ 'ctagsargs' : '',
    \ 'kinds' : [
      \ 'f:functions',
      \ 'o:object',
    \ ],
    \ 'sro' : ".",
    \ 'kind2scope' : {
      \ 'f' : 'object',
      \ 'o' : 'object',
    \ }
  \ }
endif

" for Fugitive {{{
nnoremap <Leader>gd :<C-u>Gdiff<Enter>
nnoremap <Leader>gs :<C-u>Gstatus<Enter>
nnoremap <Leader>gl :<C-u>Gitv<Enter>
nnoremap <Leader>ga :<C-u>Gwrite<Enter>
nnoremap <Leader>gc :<C-u>Gcommit<Enter>
nnoremap <Leader>gC :<C-u>Git commit --amend<Enter>
nnoremap <Leader>gb :<C-u>Gblame<Enter>
" }}}

nnoremap <Leader>c :<C-u>setlocal cursorcolumn!<CR>
nnoremap <Leader>w :<C-u>setlocal wrap!<CR>

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
nmap <Leader>t :TagbarToggle<CR>

" 縦分割版gf
nnoremap gs :vertical wincmd f<CR>

"Jade
autocmd BufNewFile,BufRead *.jade  setf jade
autocmd BufRead,BufNewFile *.swift set filetype=swift

"MemoList
"
" nnoremap <Leader>,n  :MemoNew<CR>
" nnoremap <Leader>,l  :MemoList<CR>
" nnoremap <Leader>,g  :MemoGrep<CR>
let g:memolist_path = "~/Dropbox/Memo/"
" * evervim {{{
let g:evervim_devtoken = "S=s3:U=3073f:E=1528146c26f:C=14b299595a0:P=1cd:A=en-devtoken:V=2:H=2eacb5b6ba4d1f15d55198b4dcf0d539"
nnoremap <silent> ,el :<C-u>EvervimNotebookList<CR>
nnoremap <silent> ,eT :<C-u>EvervimListTags<CR>
nnoremap <silent> ,en :<C-u>EvervimCreateNote<CR>
nnoremap <silent> ,eb :<C-u>EvervimOpenBrowser<CR>
nnoremap <silent> ,ec :<C-u>EvervimOpenClient<CR>
nnoremap ,es :<C-u>EvervimSearchByQuery<SPACE>
let g:evervim_splitoption=''
" ------------------------ }}}
let g:vimfiler_as_default_explorer = 1

" let g:tmux_navigator_no_mappings = 1
" nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
" nnoremap <silent> <C-l> :TmuxNavigateRight<cr>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nnoremap <CR> G
nnoremap <BS> gg

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

colorscheme iceberg
