
  noremap <Leader>b :Buffers<CR>
  noremap <Leader>p :GFiles<CR>
  noremap <Leader>s :GFiles?<CR>
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
  let g:fzf_preview_window = ['right:50%', 'ctrl-_']

  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
