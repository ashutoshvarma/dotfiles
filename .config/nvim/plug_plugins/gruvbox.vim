if exists('g:plug_installing_plugins')
  Plug 'morhetz/gruvbox'
  finish
endif

let g:gruvbox_italic=1

set background=dark
try
  colorscheme gruvbox
  hi Normal guibg=NONE ctermbg=NONE
catch
endtry
