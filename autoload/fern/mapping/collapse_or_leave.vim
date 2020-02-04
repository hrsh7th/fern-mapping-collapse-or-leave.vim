let g:fern#mapping#collapse_or_leave#disable_default_mappings = get(g:, 'fern#mapping#collapse_or_leave#disable_default_mappings', 0)

function! fern#mapping#collapse_or_leave#init(disable_default_mappings) abort
  let l:helper = fern#helper#new()
  if l:helper.sync.get_scheme() !=# 'file'
    return
  endif

  nmap <buffer><silent> <Plug>(fern-action-collapse-or-leave) :<C-u>call <SID>call('collapse_or_leave')<CR>

  if !g:fern#mapping#collapse_or_leave#disable_default_mappings && !a:disable_default_mappings
    nmap <buffer><silent> h <Plug>(fern-action-collapse-or-leave)
  endif
endfunction

"
" call
"
function! s:call(name) abort
  call fern#internal#mapping#call(function('s:mapping'))
endfunction

"
" mapping
"
function! s:mapping(helper) abort
  if a:helper.sync.get_scheme() !=# 'file'
    return
  endif

  let l:root_node = a:helper.sync.get_root_node()
  let l:cursor_node = a:helper.sync.get_cursor_node()

  let l:is_under_root = len(l:root_node.__key) + 1 == len(l:cursor_node.__key)
  let l:is_leaf_or_collapsed = index([g:fern#internal#node#STATUS_NONE, g:fern#internal#node#STATUS_COLLAPSED], l:cursor_node.status) >= 0
  if l:is_under_root && l:is_leaf_or_collapsed
    call feedkeys("\<Plug>(fern-action-leave)")
  else
    call feedkeys("\<Plug>(fern-action-collapse)")
  endif
endfunction

