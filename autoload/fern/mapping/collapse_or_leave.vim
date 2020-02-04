let g:fern#mapping#collapse_or_leave#disable_default_mappings = get(g:, 'fern#mapping#collapse_or_leave#disable_default_mappings', 0)

function! fern#mapping#collapse_or_leave#init(disable_default_mappings) abort
  let l:helper = fern#helper#new()
  if l:helper.sync.get_scheme() !=# 'file'
    return
  endif

  nmap <buffer><silent><expr> <Plug>(fern-action-collapse-or-leave) <SID>mapping()

  if !g:fern#mapping#collapse_or_leave#disable_default_mappings && !a:disable_default_mappings
    nmap <buffer><silent> h <Plug>(fern-action-collapse-or-leave)
  endif
endfunction

"
" mapping
"
function! s:mapping() abort
  let l:helper = fern#helper#new()
  if l:helper.sync.get_scheme() !=# 'file'
    return ''
  endif

  let l:root_node = l:helper.sync.get_root_node()
  let l:cursor_node = l:helper.sync.get_cursor_node()

  let l:is_under_root = len(l:root_node.__key) + 1 == len(l:cursor_node.__key)
  let l:is_leaf_or_collapsed = index([l:helper.STATUS_NONE, l:helper.STATUS_COLLAPSED], l:cursor_node.status) >= 0
  if l:is_under_root && l:is_leaf_or_collapsed
    return "\<Plug>(fern-action-leave)"
  else
    return "\<Plug>(fern-action-collapse)"
  endif
endfunction

