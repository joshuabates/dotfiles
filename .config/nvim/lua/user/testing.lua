local tt = require "toggleterm"
local ttt = require "toggleterm.terminal"

vim.g["test#custom_strategies"] = {
  tterm = function(cmd)
    -- TODO: if termina; is already open then make sure it's scrolling
    -- fix go_back https://github.com/akinsho/toggleterm.nvim/blob/main/lua/toggleterm/terminal.lua#L288
    tt.exec_command("cmd='" .. cmd .. "' direction=vertical go_back=1")
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
