if vim.b.did_ftplugin == 1 then
    return
end

vim.opt_local.comments = ":#"
vim.opt_local.commentstring = "# %s"

---@param args vim.api.keyset.create_user_command.command_args
local function hover(args)
    local cwd = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
    local commit_proc = vim.system({"git", "show", "--format=fuller", args.args},
                                   {cwd = cwd, text = true})

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value("filetype", "git", {buf = buf})

    local commit_result = commit_proc:wait()
    if commit_result.code ~= 0 then
        -- Don't bother handling this, as an expected failure mode is calling
        -- keywordprg on a non-ref, such as a word in a comment.
        return
    end

    local lines = vim.split(commit_result.stdout, "\n", {trimempty = false})
    table.remove(lines)

    vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
    vim.api.nvim_set_option_value("modifiable", false, {buf = buf})
    local win = vim.api.nvim_open_win(buf, false, {
        relative = "cursor",
        bufpos = {0, 0},
        width = 72,
        height = 20,
        style = "minimal",
        title = args.args:sub(1, 7)
    })
    if win == 0 then
        vim.notify("Failed to open commit window", vim.log.levels.ERROR)
    end
end

local user_command = "Keywordprg"
vim.api.nvim_create_user_command(user_command, hover,
                                 {desc = "git rev-list keywordprg", nargs = 1})
vim.opt_local.keywordprg = ":" .. user_command

vim.b.did_ftplugin = 1
