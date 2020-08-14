" Do NOT check for b:did_ftplugin here, as it is set by pyrex.vim.
setlocal commentstring=#\ %s
if expand('%:e') == "pyx"
    setlocal makeprg=cython\ -a\ -+\ %\ &&\ xdg-open\ '%<.html'
endif
