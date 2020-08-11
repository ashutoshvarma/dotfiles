" Fix files with prettier, and then ESLint.
let b:ale_linters = ['eslint', ]
let b:ale_fixers = ['prettier', 'eslint']

let b:ale_linters_explicit = 1
let b:ale_fix_on_save = 1

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
