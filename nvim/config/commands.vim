function! s:show_diff(trunk)
  let filestr = getline(".")
  let files = split(filestr)
  let trunk = a:trunk
  let dirname = files[0]
  let filepath = files[1]
  let tmpname = Rand()

  if !filereadable(join([dirname, filepath], '/'))
    echo "file not exists. check branch is correct."
    return
  endif

  execute "tabedit" join([dirname, filepath], '/')
  let filename = expand("%")
  execute "edit" join([trunk, tmpname, filename], "__")
  set buftype=nofile
  let com = ['git show ', trunk, ':', filepath]
  execute "0read" join(["!", join(com, '')], "")

  set nomod
  set ro
  execute "vertical diffsplit" filename
endfunction

command! -nargs=1 Diff call <SID>show_diff(<f-args>)
command! -nargs=0 DD call <SID>show_diff("master")

"AutoChangeDirectory
au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

autocmd BufRead,BufNewFile *.ts set filetype=typescript
autocmd BufNewFile,BufRead *.tsx let b:tsx_ext_found = 1
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
