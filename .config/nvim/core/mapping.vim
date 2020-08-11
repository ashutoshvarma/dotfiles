" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

" yank entire buffer with gy
nnoremap gy :0,$ y<cr>

" select entire buffer
nnoremap vy ggVG

" make Y behave like other capital commands.
" Hat-tip http://vimbits.com/bits/11
nnoremap Y y$

" open termainl emulator
nnoremap <silent> sh :terminal<cr>

" buffer
nnoremap <silent> <S-j> :bnext<cr>
nnoremap <silent> <S-k> :bprevious<cr>
nnoremap <silent> <leader>bx :Bclose<cr>
nnoremap <leader>bn :edit<space>
nnoremap <S-b> :edit<space>
" opens an edit command with the path of the currently edited file path
nnoremap <leader>be :edit <C-r>=expand('%:p:h') . '/'<cr>

" tab
nnoremap <silent> <S-h> :tabprevious<cr>
nnoremap <silent> <S-l> :tabnext<cr>
nnoremap <leader>tn :tabnew<space>
nnoremap <S-t> :tabnew<space>
" opens an edit command with the path of the currently edited file path
nnoremap <leader>te :tabedit <C-r>=expand('%:p:h') . '/'<cr>

" smart way to move between window
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" create newlines without entering insert mode
nnoremap go o<esc>k
nnoremap gO O<esc>j

" remap `U` to `CTRL-r` for easier redo
" From: http://vimbits.com/bits/356
nnoremap U <C-r>

" do not move on *
nnoremap <silent>* :let stay_star_view=winsaveview()<cr>
  \ *:call winrestview(stay_star_view)<cr>

" equal size windows
nnoremap <silent>s= :wincmd =<cr>

" swap windows
nnoremap <silent>sx :wincmd x<cr>

" highlight search word under cursor without jumping to next
noremap <leader>h *<C-o>

" disable highlight when `[LEADER-/]` is pressed
nnoremap <silent> <leader>/ :nohls<cr>

" split window vertically or horizontally *and* switch to the new split
nnoremap <silent> <leader>ss :split<bar>:wincmd j<cr>:wincmd =<cr>
nnoremap <silent> <leader>sv :vsplit<bar>:wincmd l<cr>:wincmd =<cr>

" set working directory
nnoremap <leader>. :lcd %:p:h<cr>

" shifting > and < in visual mode, cursor stays still
vnoremap > >gv
vnoremap < <gv

" move visual block
vnoremap J :m '>+1<cr>gv=gv'
vnoremap K :m '<-2<cr>gv=gv'

" inserts the path of the currently edited file into a command
cnoremap <C-p> <C-r>=expand('%:p:h') . '/'<cr>

" press `[CTRL-\_CTRL-n]` key or map <esc> key to exit terminal mode
" From: https://github.com/Shougo/deol.nvim
"tnoremap <esc> <C-\><C-n>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Toggle relative line number
nmap <leader><C-L> :set invrelativenumber<CR>

" vim: sw=2 ts=2 et tw=78 :
