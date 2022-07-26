local status_ok, toggleterm = pcall(require, "toggleterm")
local ok, terms = pcall(require, 'toggleterm.terminal')

if not status_ok then
	return
end
-- TODO: seperate consoles for rails console, specs, etc...
-- consider using vim for all primary project terminal stuff (e.g starting webpack)
-- https://github.com/sheodox/projectlaunch.nvim
--
-- how to handle copy/paste in terminal buffer? (c-w N)
-- add binding to toggle vertical size between default and 50%
-- fix ctrl- nav commands
-- add normal mode   to kill/continue term

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local shell = file_exists("/usr/local/bin/fish") and  "/usr/local/bin/fish" or "/opt/homebrew/bin/fish" 

toggleterm.setup({
	size = 80,
	open_mapping = [[<c-\>]],
	hide_numbers = true,
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = shell,
	float_opts = {
		border = "curved",
	},
})

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

  vim.api.nvim_buf_set_keymap(0, 'i', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 'i', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 'i', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 'i', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = terms.Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
local rails_console = Terminal:new({ cmd = "rails console", direction = "vertical" })
local start = Terminal:new({ cmd = "yarn start", hidden = true, direction = "tab" } )

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

function _RAILS_CONSOLE_TOGGLE()
	rails_console:toggle()
end

function _TOGGLE_TERMINAL_DIR()
  local term = terms.get(terms.get_toggled_id())

  if not term then return end

  local is_float = term:is_float()

  term:close()

	if is_float then
    term:change_direction("vertical")
  else
    term:change_direction("float")
  end

  term:open()
end

function _START_APP_TOGGLE()
	start:toggle()
end

-- Dupes?
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-t>', [[<C-\><C-n><leader>ct]], opts)

  -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

function _TERMINAL_EOD()
  toggleterm.exec_command("cmd='' go_back=1")
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
