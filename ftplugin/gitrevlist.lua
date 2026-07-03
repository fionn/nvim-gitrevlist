if vim.b.did_ftplugin == 1 then
    return
end

vim.opt_local.comments = ":#"
vim.opt_local.commentstring = "# %s"

vim.opt_local.keywordprg = "git show"

vim.b.did_ftplugin = 1
