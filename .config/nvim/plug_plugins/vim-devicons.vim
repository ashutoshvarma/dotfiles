if exists('g:plug_installing_plugins')
  Plug 'ryanoasis/vim-devicons'
  finish
endif


" loading the plugin
let g:webdevicons_enable = 1

" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1

set t_Co=256
set termguicolors

set background=dark
try
  colorscheme gruvbox
catch
endtry


