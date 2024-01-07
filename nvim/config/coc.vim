nmap <silent> ck <Plug>(coc-diagnostic-prev)
nmap <silent> cj <Plug>(coc-diagnostic-next)
nmap <silent> <C-e> :CocList<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> <leader>ci <Plug>(coc-implementation)
nmap <silent> <leader>cr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> <leader>ci :call <SID>organize_import()<CR>
nnoremap <silent> <leader>cs :call <SID>goto_super()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:goto_super()
  if (index(['java'], &filetype) >= 0)
    call CocAction('runCommand', 'java.action.navigateToSuperImplementation')
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

" 補完候補の選択
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
