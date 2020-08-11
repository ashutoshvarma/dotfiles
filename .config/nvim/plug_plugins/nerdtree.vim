" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

if exists('g:plug_installing_plugins')
  Plug 'scrooloose/nerdtree'
  finish
endif

if has('autocmd')
  augroup auto_nerdtree_settings
    autocmd!

    " close vim if NERDTree is the last buffer
    autocmd BufEnter * if (winnr('$') is# 1 && exists('b:NERDTree')
      \&& b:NERDTree.isTabTree()) | q | endif

    autocmd FileType nerdtree setlocal nocursorline
  augroup END
endif

let g:NERDTreeShowBookmarks = 1
let g:NERDTreeChDirMode = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeHighlightCursorLine = 0
let g:NERDTreeWinSize = 30
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeNodeDelimiter = "\u00a0"
let g:NERDTreeIgnore = [
  \ '\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__' ]
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']

nnoremap <silent> <F2> :NERDTreeToggle<cr>:wincmd =<cr>

" vim: set sw=2 ts=2 et tw=78 :
