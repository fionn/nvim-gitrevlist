if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal comments=:#
setlocal commentstring=#\ %s
setlocal keywordprg=git\ show

let b:undo_ftplugin = "setl comments< commentstring< keywordprg<"
