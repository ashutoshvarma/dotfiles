" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

for file in split(glob($VIM_PATH . '/plug_plugins/*.vim'), "\n")
  execute 'source' fnameescape(file)
endfor
for file in split(glob($VIM_PATH . '/plug_plugins/custom/*.vim'), "\n")
  execute 'source' fnameescape(file)
endfor

" vim: sw=2 ts=2 et tw=78 :
