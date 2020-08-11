" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

let s:vimplug_path = expand($VIM_PATH) . '/autoload/plug.vim'
if !filereadable(s:vimplug_path)
  if !executable('curl')
    echoerr 'You have to install curl or first install vim-plug yourself!'
    execute 'q!'
  endif
  let s:vimplug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  echo 'Installing Vim-Plug...'
  echo ''
  silent exec '!\curl -fLo ' . s:vimplug_path . ' --create-dirs ' . s:vimplug_url
  unlet s:vimplug_url

  autocmd VimEnter * PlugInstall
endif
unlet s:vimplug_path

" specify a directory for plugins
call plug#begin(expand(g:cache_path) . '/plugged')
let g:plug_installing_plugins = 1

" source all the plugins with a global variable set that ensures only the
" `Plug 'name'` code will be called
for file in split(glob($VIM_PATH . '/plug_plugins/*.vim'), "\n")
  execute 'source' fnameescape(file)
endfor
for file in split(glob($VIM_PATH . '/plug_plugins/custom/*.vim'), "\n")
  execute 'source' fnameescape(file)
endfor

unlet g:plug_installing_plugins
" initialize plugin system
call plug#end()

" vim: sw=2 ts=2 et tw=78 :
