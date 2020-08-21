" Copyright (c) 2019-present Kaiming Guo. All rights reserved.
" Use of this source code is governed by a BSD-style license that can be
" found in the LICENSE file.

if exists('g:plug_installing_plugins')
  if isdirectory('/usr/local/opt/fzf')
    Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'  " hidden readme
  else
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }  " hidden readme
    Plug 'junegunn/fzf.vim'
  endif
  finish
endif

if has('autocmd')
  augroup auto_fzf_settings
    if has('nvim') && !exists('g:fzf_layout')
      autocmd! FileType fzf
      autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
    endif
  augroup END
endif

let $FZF_DEFAULT_OPTS = '--bind ctrl-d:preview-page-down,ctrl-u:preview-page-up'
let $FZF_DEFAULT_COMMAND =
  \ get(g:, 'fzf_default_cmd',
  \   !empty($FZF_DEFAULT_COMMAND) ? $FZF_DEFAULT_COMMAND :
  \   executable('rg') ? 'rg --files --hidden --follow --glob "!.git" ' :
  \   executable('ag') ? 'ag --hidden --ignore .git -g ""' :
  \   executable('fd') ? 'fd --type f' :
  \   'find * -path "*/\.*" -prune -o -path "node_modules/**" -prune -o -path "target/**" -prune -o -path "dist/**" -prune -o -type f -print -o -type l -print 2> /dev/null'
  \ )

if executable('rg')
  set grepprg=rg\ --vimgrep
  command! -bang -nargs=* Find call fzf#vim#grep(
    \'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "\!.git/*" --color "always" '
    \. '| tr -d "\017"', 1, <bang>0)
elseif executable('ag')
  set grepprg=ag\ --nogrup\ --nocolor
endif

let s:ctags_bin = get(g:, 'ctags_bin', 'ctags')
let g:fzf_tags_command = s:ctags_bin . ' -R'
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_preview_window = 'right:50%'
let g:fzf_commits_log_options = '--graph --color=always --pretty="%Cred%h%Creset%C(yellow)%d%Creset %s %Cgreen(%cr) %C(blue)<%an>%Creset" --abbrev-commit'
let g:fzf_colors = {
  \ 'fg': ['fg', 'Normal'],
  \ 'bg': ['bg', 'Normal'],
  \ 'hl': ['fg', 'Comment'],
  \ 'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+': ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+': ['fg', 'Statement'],
  \ 'info': ['fg', 'PreProc'],
  \ 'border': ['fg', 'Ignore'],
  \ 'prompt': ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker': ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header': ['fg', 'Comment']
  \ }
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit'}

nnoremap <silent> <leader>fi :FzfFilesWithDevIcon<cr>
nnoremap <silent> <leader>ff :Files<cr>
nnoremap <silent> <leader>fp :ProjectFiles<cr>
nnoremap <silent> <leader>bb :Buffers<cr>
nnoremap <silent> <leader>gf :GFiles?<cr>
nnoremap <silent> <leader>glo :Commits<cr>
nnoremap <silent> <leader>glb :BCommits<cr>
nnoremap <silent> <leader>gr :GGrep<cr>
nnoremap <silent> <leader>fh :History<cr>

" advanced customization using autoload functions
inoremap <expr> <C-x><C-k> fzf#vim#complete#word({'left': '15%'})

""
" @private
" Get the git repo root
" From: https://github.com/junegunn/fzf.vim/issues/47#issuecomment-160237795
""
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

""
" @private
" Get file and devicons
" From: https://github.com/ryanoasis/vim-devicons/issues/106
function! s:FzfFilesWithDevIcons() abort
  if executable('bat')
    let l:fzf_files_options = printf(' -m --bind ctrl-d:preview-page-down,ctrl-u:preview-page-up --preview "bat --color always --style numbers %s %s | head -%s"',
      \ '--style=numbers,changes --color always',
      \ exists('*WebDevIconsGetFileTypeSymbol') ? '{2..-1}' : '{}',
      \ &lines)
  else
    let l:fzf_files_options = ''
  endif

  function! s:GetFiles()
    let l:files = split(system($FZF_DEFAULT_COMMAND), "\n")
    return <sid>PrependIcon(l:files)
  endfunction

  function! s:PrependIcon(candidates)
    let l:result = []
    for candidate in a:candidates
      let l:fname = fnamemodify(candidate, ':p:t')
      if exists('*WebDevIconsGetFileTypeSymbol')
        let l:icon = WebDevIconsGetFileTypeSymbol(l:fname, isdirectory(l:fname))
        call add(l:result, printf('%s %s', l:icon, candidate))
      else
        call add(l:result, candidate)
      endif
    endfor
    return l:result
  endfunction

  function! s:EditFile(item)
    let l:pos = stridx(a:item, ' ')
    let l:file_path = a:item[pos+1:-1]
    execute 'silent e' l:file_path
  endfunction

  call fzf#run({
    \ 'source': <sid>GetFiles(),
    \ 'sink': function('s:EditFile'),
    \ 'options': '-m ' . l:fzf_files_options,
    \ 'down': '40%' })
endfunction
command! FzfFilesWithDevIcons call <sid>FzfFilesWithDevIcons()

" similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" command for git grep
" - fzf#vim#grep(command, with_column, [options], [fullscreen])
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" augmenting Ag command using fzf#vim#with_preview function
"   * fzf#vim#with_preview([[options], [preview window], [toggle keys...]])
"     * For syntax-highlighting, Ruby and any of the following tools are required:
"       - Bat: https://github.com/sharkdp/bat
"       - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"       - CodeRay: http://coderay.rubychan.de/
"       - Rouge: https://github.com/jneen/rouge
"
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" vim: set sw=2 ts=2 et tw=78 :
