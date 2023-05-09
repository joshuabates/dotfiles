require "user.options"
require "user.plugins"

local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  return
end

require "user.keymaps"
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
-- FIX BUGS
--
-- lsp doesn't alays work... (needs to be automatic)
-- keep getting enter outputting qq
-- keep getting dual imports on save
-- gotofile should work with js imports
--
-- - sometimes get stuck with an out of focus float window
--
-- telescope start search and then select directory to narow it down with
-- get remote-neovim working for git?
-- use a seperate background for a embedded terminal vs a kitty one
-- improve autocomplete. how?
-- snippets?
-- react stuff
--
-- improve ruby lsp. should atleast work with local file docs and non-rails gems
-- better "go to implementation" (flexible based on server?)
-- copy filepath:line
-- lua autoformatting
--
-- git history for current file
-- better toggleterm config?
-- tests -> quickfix
-- diagnostics -> quickfix
-- quickfix navigation
--
-- hydra
--
-- define filtered and labeled g prefix in whichkey
--
-- JS
-- Run yarn in a terminal, watch for errors and show notification when it breaks (and maybe even restart?) w/ option of going to error line in file
--
-- memorize surround keys: ys, cs, ds t(ag), f(n)
