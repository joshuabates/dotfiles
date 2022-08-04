local tt = require "toggleterm"

vim.g["test#custom_strategies"] = {
  tterm = function(cmd)
    -- TODO: if termina; is already open then make sure it's scrolling
    -- fix go_back https://github.com/akinsho/toggleterm.nvim/blob/main/lua/toggleterm/terminal.lua#L288
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local winnr = vim.api.nvim_get_current_win()

    tt.exec_command("cmd='" .. cmd .. "' direction=vertical")
    vim.cmd("stopinsert!")
    vim.api.nvim_win_set_cursor(winnr, { line, col })
    -- vim.api.nvim_set_current_win(winnr)
    -- vim.api.nvim_set_current_line(linenr)
  end,

  tterm_close = function(cmd)
    local term_id = 0
    tt.exec(cmd, term_id)
    tt.get_or_create_term(term_id):close()
  end,
}
-- vim.g["test#javascript#jest#file_pattern"] = '.*(spec|test|Spec|Test))\.(js|jsx|coffee|ts|tsx)$'
vim.g["test#javascript#jest#file_pattern"] = "\\vSpec\\.(js|jsx|ts|tsx)$"
vim.g["test#javascript#jest#executable"] = "yarn test"
vim.g["test#javascript#runner"] = 'jest'
vim.g["test#strategy"] = "tterm"
