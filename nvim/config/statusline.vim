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
