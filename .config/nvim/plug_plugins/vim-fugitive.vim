" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

if exists('g:plug_installing_plugins')
  Plug 'tpope/vim-fugitive'
  finish
endif

" bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gu :Git restore --staged %:p<CR>

" vim: set sw=2 ts=2 et tw=78 :
