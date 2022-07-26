require "user.options"
require "user.keymaps"
require "user.plugins"
require "user.colorscheme"

require "user.autopairs"
require "user.cmp"
require "user.comment"
require "user.commands"
require "user.gitsigns"
require "user.indentline"
require "user.lsp"
require "user.lualine"
require "user.nvim-tree"
require "user.quickfix"
require "user.telescope"
require "user.testing"
require "user.toggleterm"
require "user.treesitter"

require "user.ruby"
-- TODO:
-- better toggleterm config?
-- tests -> quickfix
-- diagnostics -> quickfix
-- git blame
-- move down a line after comment
-- quickfix navigation
--
-- leap, leap-ast
-- hydra
--
-- define filtered and labeled g prefix in whichkey
--
-- JS
-- Run yarn in a terminal, watch for errors and show notification when it breaks (and maybe even restart?) w/ option of going to error line in file
--
-- copy file w/ line#
-- function M.yank_file_path()
--   local current_file = vim.fn.expand("%:r")
--   local extension = vim.fn.expand("%:e")
--   local current_line = vim.fn.line(".")
--   return current_file .. "." .. extension .. ":" .. current_line
-- end
