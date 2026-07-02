" git_push.vim - Smart git push with auto upstream setup
" Maintainer: lyuangg
" Version:    1.0

if exists('g:loaded_git_push')
  finish
endif
let g:loaded_git_push = 1

function! s:GitPushWithUpstream() abort
  let branch = substitute(system('git rev-parse --abbrev-ref HEAD 2>/dev/null'), '\n$', '', '')
  if v:shell_error != 0 || empty(branch)
    echohl ErrorMsg | echo 'Not a git repository' | echohl None
    return
  endif

  let out = system('git push 2>&1')
  if v:shell_error == 0
    echohl MoreMsg | echo out | echohl None
    return
  endif

  if out =~# 'set-upstream\|has no upstream'
    let cmd = 'git push -u origin ' . shellescape(branch)
    if confirm('Push with upstream: ' . cmd . ' ?', "&Yes\n&No", 1) == 1
      let out = system(cmd . ' 2>&1')
      if v:shell_error == 0
        echohl MoreMsg | echo out | echohl None
      else
        echohl ErrorMsg | echo out | echohl None
      endif
    endif
  else
    echohl ErrorMsg | echo out | echohl None
  endif
endfunction

command! GitPush call s:GitPushWithUpstream()
noremap <Leader>gP :GitPush<CR>
