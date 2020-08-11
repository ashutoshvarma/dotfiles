" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

" Auto Commands {{{

if has('autocmd')
  augroup auto_custom_settings
    " clear the auto command group so we don't define it multiple times idea
    " from: http://learnvimscriptthehardway.stevelosh.com/chapters/14.html
    autocmd!

    " when editing a file, always jump to the last current position
    " this must be after the uncompress command
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') |
      \ exe "normal! g'\"" | endif

    " resize splits when the window is resized
    " From: https://bitbuck.org/sjl/dotfiles/src/tip/vim/vimrc
    autocmd VimResized * :wincmd =

    " disable visualbell
    autocmd GUIEnter * set visualbell t_vb=

    " the PC is fast enough, do syntax highlight syncing from start unless
    " 200 lines
    autocmd BufEnter * :syntax sync maxlines=200
  augroup END

  augroup auto_make_settings
    autocmd!

    autocmd FileType make setlocal noexpandtab
    autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
  augroup END
endif

" }}}

" General {{{

" sets how many lines of history Vim has to remember
set history=500

" attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific
filetype indent plugin on

" set to auto read when a file is change from the outside
set autoread

" }}}

" Vim User Interface {{{

" set 7 lines to the cursor - when moving vertically using j/k
set so=7

" avoid garbled characters in Chinese language windows OS
set langmenu=en
exec 'source ' . $VIMRUNTIME . '/delmenu.vim'
exec 'source ' . $VIMRUNTIME . '/menu.vim'

" better command-line completion
set wildmenu

" ignore compiled files
set wildignore+=*.o,*.obj,*.exe,*.so,*.dll,*.pyc,.svn,.hg,.bzr,.git,
  \.sass-cache,*.class,*.scssc,*.cssc,sprockets%*,*.lessc,*/node_modules/*,
  \rake-pipeline-*

" display line numbers on the left
set number

" a buffer becomes hidden when it is abandoned
set hidden

" configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" highlight search results
set hlsearch

" vim loves to redraw the screen during things it probably doesn't need
" to--like in the middle of macros. This tells Vim not to bother redrawing
" during these scenarios, leading to faster macros
set lazyredraw

" for regular expressions turn magic on
set magic

" with `showmatch`, when your cursor moves over a parenthesis-like
" character, the matching one will be highlighted as well
set showmatch

" how many tenths of a second to blink when matching brackets
set mat=5

" no annoying sound on errors
set noerrorbells visualbell t_vb=

" color the 88th column differently as a wrapping guide
" 88 for black compatibility
if exists('+colorcolumn')
  set colorcolumn=88
endif

" quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" }}}

" Colors and Fonts {{{

" enable syntax highlighting
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" force 256 color mode if available
if $TERM =~ '-256color'
  set t_Co=256
  set t_ut=
endif

set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

" }}}

" Files and Backups {{{

" set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8

" use Unix as the standard file type
set fileformats=unix,dos,mac

" }}}

" Text, Tab and Indent Related {{{

" yanks go on clipboard instead
if has('clipboard')
  if has('unnamedplus')
    " when possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else
    " on macOS and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

" use spaces instead of tabs 
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" linebreak on 500 characters
set linebreak
set textwidth=500

" use multiple of shiftwidth when indenting with '<' nad '>'
set shiftround

" auto-indent spaces with C in vim
set autoindent
set cindent

" }}}

" Moving Around, Tabs and Buffers {{{

" specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" }}}

" Status Line {{{

" display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" always display the status line, even if only one window is displayed
set laststatus=2

" set the command window height to 2 lines, to avoid many cases of having to
" `press <Enter> to continue`
set cmdheight=2

" default status line format
set statusline=%<%f\ %h%m%r\ %y%=%{v:register}\ %-14.(%l,%c%V%)\ %P

" }}}

" Misc {{{

" enable mouse in normal/visual mode only
set mouse=nv

" hiden when characters are typed
set mousehide

if has('*mouse_sgr')
  set ttymouse=sgr
endif

" }}}

" Platform Options {{{

" set extra options when running in GUI mode
if has('gui_running')
  set guioptions-=T
  set guioptions-=e
  set guitablabel=%M\ %t
  set tm=500
endif

if has('mac') || has('macunix')
  if has('gui_running')
    if has('gui_mac') || has('gui_macvim')
      set guifont=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
      set transparency=7
    endif
    " use option (alt) as meta key
    set macmeta
  endif
elseif has('win16') || has('win32')
  set guifont=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has('gui_gtk2')
  set guifont=IBM\ Plex\ Mono\ 14,Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has('unix')
  set guifont=Monospace\ 11
endif

" }}}

" Helper Function and Commands {{{

" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev wQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" silently execute an external command
" No 'Press Any Key to Contiue BS'
" From: http://vim.wikia.com/wiki/Avoiding_the_%22Hit_ENTER_to_continue%22_prompts
command! -nargs=1 SilentCmd
  \ | execute ':silent !' . <q-args>
  \ | execute ':redraw!'

""
" @private
" Don't close window, when deleting a last buffer.
function! s:BufClose() abort
  let l:current_buf_num = bufnr('%')
  let l:alternate_buf_num = bufnr('#')

  if buflisted(l:alternate_buf_num)
    buffer #
  else
    bnext
  endif

  if bufnr('%') is# l:current_buf_num
    new
  endif

  if buflisted(l:current_buf_num)
    execute('bdelete! ' . l:current_buf_num)
  endif
endfunction
command! Bclose call <sid>BufClose()

""
" @private
" Quick spelling fix (first item in z= list)
function! s:QuickSpellingFix() abort
  if &spell
    normal 1z=
  else
    " Enable spelling mode and do the correction
    set spell
    normal 1z=
    set nospell
  endif
endfunction
command! QuickSpellingFix call <sid>QuickSpellingFix()

""
" @private
" Paste using paste mode, keeps indentation in source.
function! s:PasteWithPasteMode() abort
  if &paste
    normal p
  else
    " Enable paste mode and paste the text, then disable paste mode.
    set paste
    normal p
    set nopaste
  endif
endfunction
command! PasteWithPasteMode call <sid>PasteWithPasteMode()

" }}}

" For neovim compatiblity with venvs
" make 'neovim' virtualenv and set its python exec path explicitly
let nvim_venv_python3_host = '$HOME/.pyenv/versions/neovim/bin/python'
if has('nvim') && filereadable(expand(nvim_venv_python3_host))
  let g:python3_host_prog = nvim_venv_python3_host
endif

" vim: sw=2 ts=2 et tw=78 :
