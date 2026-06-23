if vim.b.did_ftplugin == 1 then
    return
end

vim.opt_local.comments = ":#"
vim.opt_local.commentstring = "# %s"

---@param args vim.api.keyset.create_user_command.command_args
local function git_show(args)
    if not string.match(args.args, "%x+")
       or not (string.len(args.args) == 40 or string.len(args.args) == 64) then
        vim.notify("No information available", vim.log.levels.DEBUG)
        return
    end

    local cmd = {"git", "show", "--no-color", args.args}
    local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    local commit_result = vim.system(cmd, {cwd = cwd, text = true}):wait()
    if commit_result.code ~= 0 then
        vim.notify("Git returned non-zero exit code " .. commit_result.code,
                   vim.log.levels.ERROR)
        return
    end

    local _, win = vim.lsp.util.open_floating_preview(
        vim.split(commit_result.stdout, "\n"), "git", {
            width = 78,
            height = 20,
            title = args.args:sub(1, 7),
            title_pos = "left"
        }
    )
    if win == 0 then
        vim.notify("Failed to open commit preview", vim.log.levels.ERROR)
    end
end

local ex_command = "GitShow"
vim.api.nvim_create_user_command(ex_command, git_show,
                                 {desc = "git rev-list keywordprg", nargs = 1})
vim.opt_local.keywordprg = ":" .. ex_command

vim.b.undo_ftplugin = (vim.b.undo_ftplugin or "")
    .. "\n setl comments<"
    .. "\n setl commentstring<"
    .. "\n delcommand " .. ex_command
    .. "\n setl keywordprg<"

vim.b.did_ftplugin = 1
