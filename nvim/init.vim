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
set signcolumn=number

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25

augroup netrw
  autocmd!
  autocmd FileType netrw map <buffer> l <Return>
  autocmd FileType netrw map <buffer> h -
  autocmd FileType netrw map <buffer> q :bd<Return>
  autocmd FileType netrw map <buffer> <C-h> <C-w>W
  autocmd FileType netrw map <buffer> <C-l> <C-w>w
  autocmd FileType netrw hi netrwMarkFile cterm=NONE ctermfg=140 ctermbg=234 guifg=234 guibg=234
augroup END

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
  call dein#add('nvim-treesitter/nvim-treesitter', { 'merged': 0 })

  call dein#add('vifm/vifm.vim')
  call dein#add('tpope/vim-surround')
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('thinca/vim-qfreplace')
  call dein#add('mileszs/ack.vim')

  call dein#add('junegunn/fzf', { 'build': './install --all', 'merged': 0 }) 
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('tpope/vim-fugitive')

  call dein#add('mattn/emmet-vim')

  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
  call dein#add('antoinemadec/coc-fzf')
  " call dein#add('styled-components/vim-styled-components', {'on_ft': ['javascript', 'javascript.jsx', 'typescript', 'typescript.jsx']})

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
" vifm
let g:vifm_replace_netrw = 1
let g:vifm_embed_term = 1

" fzf
noremap <Leader>b :Buffers<CR>
noremap <Leader>p :GFiles<CR>
noremap <Leader>m :History<CR>
noremap <Leader>c :BCommits<CR>
noremap <Leader>e :EditVifm<CR>
" query, ag options, fzf#run options, fullscreen
autocmd VimEnter *
\ command! -bang -nargs=* Ag
\ call fzf#vim#ag(<q-args>, '', { 'options': '--bind ctrl-a:select-all,ctrl-d:deselect-all' }, <bang>0)
autocmd! FileType fzf noremap <buffer> <ESC><ESC> :q<CR>
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors = { 'border':  ['fg', 'Ignore'] }

" 補完候補の選択
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

""AutoChangeDirectory
au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

" cnoreabbrev Ack Ack!
nnoremap <Leader>a :Gcd <bar> Ack!<Space>
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  let g:ack_qhandler = "botright copen 30"
endif

autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx

" Coc
nmap <silent> <C-k> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-j> <Plug>(coc-diagnostic-next)
nmap <silent> <C-e> :CocList<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>ci :call <SID>organize_import()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:organize_import()
  if (index(['java'], &filetype) >= 0)
    call CocAction('runCommand', 'java.action.organizeImports')
  elseif (index(['typescript'], &filetype) >= 0)
    call CocAction('runCommand', 'tsserver.organizeImports')
  endif
endfunction

" Remap for rename current word
nmap <silent> <leader>rn <Plug>(coc-rename)
" Remap for format selected region
xmap <silent> <leader>=  <Plug>(coc-format-selected)
nmap <silent> <leader>=  <Plug>(coc-format-selected)
nmap <silent> <leader>ca  <Plug>(coc-codeaction)
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

" tree-sitter

lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
EOF

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '⚑ ' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '⚐ ' . info['warning'])
  endif
  return join(msgs, ' ') . get(g:, 'coc_status', '')
endfunction

" ファイル名表示
set statusline=%y\ %{expand('%:p:h:t')}/%t
" " これ以降は右寄せ表示
set statusline+=%=
set statusline+=%{StatusDiagnostic()}
"ファイルタイプ表示
set statusline+=\ %{&fenc}
" 現在行数/全行数
set statusline+=\ (%c/%l/%L)

" ステータスラインを常に表示(0:表示しない、1:2つ以上ウィンドウがある時だけ表示)
set laststatus=2

colorscheme iceberg

"hi StatusLine term=NONE cterm=NONE ctermfg=238 ctermbg=234 guifg=234 guibg=234
hi StatusLine cterm=NONE ctermfg=251 ctermbg=234 guifg=234 guibg=234
hi StatusLineNC ctermfg=234 ctermbg=241  guifg=234 guibg=234
hi StatusLineTerm term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234
hi StatusLineTermNC term=NONE cterm=NONE ctermfg=234 ctermbg=234 guifg=234 guibg=234
" tab
hi TabLineFill ctermbg=234 ctermfg=234 guibg=NONE guifg=None
hi TabLineSel ctermbg=234 ctermfg=251 guibg=NONE guifg=None
hi TabLine ctermbg=234 ctermfg=239 guibg=NONE guifg=None
hi SignColumn ctermbg=234 ctermfg=239 guibg=NONE guifg=None

hi VertSplit cterm=NONE ctermfg=234 ctermbg=234 guibg=234 guifg=234
hi ModeMsg cterm=NONE ctermfg=234 ctermbg=234 guibg=234 guifg=234

autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
