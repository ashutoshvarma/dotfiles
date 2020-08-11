" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

if exists('g:plug_installing_plugins')
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'  " hidden readme
  finish
endif

let g:airline_theme = 'gruvbox'
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline_skip_empty_sections = 1
let g:airline_mode_map = {
   \ '__'     : '-',
   \ 'c'      : 'C',
   \ 'i'      : 'I',
   \ 'ic'     : 'I',
   \ 'ix'     : 'I',
   \ 'n'      : 'N',
   \ 'multi'  : 'M',
   \ 'ni'     : 'N',
   \ 'no'     : 'N',
   \ 'R'      : 'R',
   \ 'Rv'     : 'R',
   \ 's'      : 'S',
   \ 'S'      : 'S',
   \ ''     : 'S',
   \ 't'      : 'T',
   \ 'v'      : 'V',
   \ 'V'      : 'V',
   \ ''     : 'V',
   \ }

let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#hunks#enabled = 0

" vim: set sw=2 ts=2 et tw=78 :
