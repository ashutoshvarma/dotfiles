" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

" set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
if has('vim_starting')
  " set compatiblity to vim only
  if &compatible | set nocompatible | endif
endif

" include user's extra bundle
if filereadable(expand('$HOME/.vimrc.local'))
  source $HOME/.vimrc.local
endif

" initialize base requirements
if !has('g:mapleader')
  " use [,] as leader required before loading plugins
  let mapleader=','
  let g:mapleader=','
endif

let $VIM_PATH =
  \ get(g:, 'vim_path',
  \   exists('*stdpath') ? stdpath('config') :
  \   !empty($VIM_PATH) ? expand($VIM_PATH) :
  \   fnamemodify(resolve(expand('<sfile>:p')), ':h')
  \ )

let g:cache_path =
  \ expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '$HOME/.cache')) . '/vim'

if &runtimepath !~# expand($VIM_PATH)
  execute 'set runtimepath^=' . $VIM_PATH
endif

execute 'source' fnameescape(expand($VIM_PATH) . '/core/general.vim')
execute 'source' fnameescape(expand($VIM_PATH) . '/core/mapping.vim')
execute 'source' fnameescape(expand($VIM_PATH) . '/core/plug.vim')
execute 'source' fnameescape(expand($VIM_PATH) . '/core/plug_setting.vim')

" vim: sw=2 ts=2 et tw=78 :
