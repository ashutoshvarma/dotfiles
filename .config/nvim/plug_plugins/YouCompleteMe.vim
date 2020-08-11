" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

function! BuildYcmd(info) abort
  if a:info.status == 'installed' || a:info.force
    !./install.py --clang-completer
  endif
endfunction

if exists('g:plug_installing_plugins')
  Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYcmd') }
  finish
endif

let g:ycm_show_diagnostics_ui = 0
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1

" nvim does not have popup support yet.
set completeopt-=preview
"let g:ycm_add_preview_to_completeopt = 1
"let g:ycm_autoclose_preview_window_after_completion = 1

" will use the first python exec in PATH, helpful for venvs
let g:ycm_python_binary_path = 'python'

let g:ycm_semantic_triggers = {
  \ 'cs,java,javascript,typescript,d,python,perl6,scala,vb,elixir,go': ['.'],
  \ 'ruby,c,cpp': ['.', '::'],
  \ 'gitcommit': ['#', ':']
  \ }

" Overwritten so we can allow markdown completion.
let g:ycm_filetype_blacklist = {
  \ 'notes': 1,
  \ 'unite': 1,
  \ 'tagbar': 1,
  \ 'pandoc': 1,
  \ 'qf': 1,
  \ 'vimwiki': 1,
  \ 'text': 1,
  \ 'infolog': 1,
  \ 'mail': 1
  \ }


noremap <leader>gd :YcmCompleter GetDoc<cr>

" vim: set sw=2 ts=2 et tw=78 :
