if exists('g:plug_installing_plugins')
  Plug 'dense-analysis/ale'
  finish
endif

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

let g:ale_echo_msg_format = '[%linter%][%severity%]: %s [%code%]'

" enable only explicit linters
let g:ale_linters_explicit = 1

" disable ale completion
let g:ale_completion_enabled = 0

"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0

let g:ale_sign_error = '❌'
"let g:ale_sign_error = ''
let g:ale_sign_warning = ''

let g:ale_linter_aliases = {'typescriptreact': 'typescript'}

nmap <silent> <A-k> <Plug>(ale_previous_wrap)
nmap <silent> <A-j> <Plug>(ale_next_wrap)

nmap <F8> <Plug>(ale_fix)
nmap <leader>ta :ALEToggleBuffer<cr>



