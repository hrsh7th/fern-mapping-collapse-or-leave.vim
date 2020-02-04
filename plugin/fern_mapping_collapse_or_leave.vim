if exists('g:fern_mapping_collapse_or_leave')
  finish
endif
let g:fern_mapping_collapse_or_leave = v:true

call add(g:fern#internal#mapping#mappings, 'collapse_or_leave')

