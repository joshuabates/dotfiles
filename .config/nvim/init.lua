require("user.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

require("plugins")

require("user.keymaps")
require("user.colorscheme")

require("user.cmp")
require("user.comment")
require("user.commands")
require("user.gitsigns")
require("user.indentline")
require("user.lualine")
require("user.nvim-tree")
require("user.quickfix")
require("user.telescope")
require("user.testing")
require("user.toggleterm")
require("user.treesitter")

require("user.ruby")

-- TODO:
-- X switch from packer to lazy
-- beter org of plugins
-- mason
-- dap
-- flash
--
-- FIX BUGS
-- gotofile should work with js imports
--
-- sometimes get stuck with an out of focus float window
--
-- telescope start search and then select directory to narow it down with
-- get remote-neovim working for git?
-- use a seperate background for a embedded terminal vs a kitty one
-- snippets?
-- react stuff
--
-- improve ruby lsp. should atleast work with local file docs and non-rails gems
-- better "go to implementation" (flexible based on server?)
-- copy filepath:line
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
-- limit error messages when running yarn
--
-- memorize surround keys: ys, cs, ds t(ag), f(n)
