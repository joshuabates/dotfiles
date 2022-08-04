-- TODO: Just use whichkey for all my keymaps?
-- that would be built in docs. Only issue is if I want to move away from it
local keymap = vim.keymap.set
local opts = { silent = true }

keymap("i", "<F1>", "<Esc>", opts)
keymap("n", "<F1>", "<Esc>", opts)

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
keymap("n", "<leader>w", ":w<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Fix window navigation in netrw buffers
function set_netrw_keymaps()
  local opts = { silent = true, buffer = true }
  keymap("n", "<C-h>", ":wincmd h<cr>", opts)
  keymap("n", "<C-j>", ":wincmd j<cr>", opts)
  keymap("n", "<C-k>", ":wincmd k<cr>", opts)
  keymap("n", "<C-l>", ":wincmd l<cr>", opts)
end

vim.cmd('autocmd! filetype netrw lua set_netrw_keymaps()')


-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

keymap("n", "Q", "<Nop>", opts)

-- " Switch between files with leader-leader
keymap("n", "<leader><leader>", "<C-^>", opts)
--
-- " Select last pasted block
keymap("n", "gp", "`[v`]", opts)

-- "This unsets the "last search pattern" register by hitting return
keymap("n", "<CR>", ":noh<CR><CR>", opts)

-- TODO
-- "gF goto file @ line#
-- keymap("n", "<Leader>p", ":let @+ = expand('%:.') . ':' . line('.')<CR>", opts)

-- keymap("n", "<leader>v", ":source $MYVIMRC<CR>", opts)
keymap("n", "<leader>w", ":wa<cr>", opts)

-- " Cycle through lines in the quickfix list
keymap("n", "<leader>j", ":w<CR>:cn<CR>", opts)
keymap("n", "<leader>k", ":w<CR>:cp<CR>", opts)
-- " Cycle through files in the quickfix list
keymap("n", "<leader>J", ":w<CR>:cN<CR>", opts)
keymap("n", "<leader>K", ":w<CR>:cP<CR>", opts)

-- Telescope
keymap("n", "<leader>t", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>b", "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>", opts)

-- Comment
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- Git
keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

keymap("n", "<leader>x", "<cmd>lua CloseQuickFixOrBuffer()<CR>", opts)


-- keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", opts)

-- Trouble / Quicklist / Diagnostics

local wk = require("which-key")

-- local mappings = {
--   x = {
--     name = "Trouble",
--
--     -- x = { "<cmd>Trouble<cr>", "Trouble" }, 
--     -- w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workplace" },
--     -- f = { "<cmd>Trouble document_diagnostics<cr>", "File" },
--     -- l = { "<cmd>Trouble loclist<cr>", "Locations" },
--     -- q = { "<cmd>Trouble quickfix<cr>", "Quickfix" }
--     -- `:w
--     -- `
-- -- builtin.quickfixhistory	Lists all quickfix lists in your history and open them with builtin.quickfix
--     --builtin.lsp_workspace_symbols	Lists LSP document symbols in the current workspace
-- -- builtin.lsp_dynamic_workspace_symbols	Dynamically Lists LSP for all workspace symbols
--   }
-- }
-- wk.register(mappings, { prefix = "<leader>" })

-- -- jump to the next item, skipping the groups
-- keymap("n", "<leader>j", function()
--   require("trouble").next({skip_groups = true, jump = true});
-- end)
--
-- -- jump to the prev item, skipping the groups
-- keymap("n", "<leader>k", function()
--   require("trouble").previous({skip_groups = true, jump = true});
-- end)

-- -- jump to the next group
-- keymap("n", "<leader>J", function()
--   require("trouble").next({skip_groups = false, jump = true});
-- end)
--
-- -- jump to the prev group
-- keymap("n", "<leader>K", function()
--   require("trouble").previous({skip_groups = false, jump = true});
-- end)

wk.register({
  g = {
    name = "Go",

    -- % - cycle results
    -- b,c comment toggl
    -- x open w/ system app
    -- ' marks
    e = "End of prev word",
    f = "File",
    g = "First line",
    i = "Last insert",
    p = "Last paste",
    v = "Last selection",
    u = "Lowercase",
    U = "Uppercase",

    s = { "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>", "Search word"},
    r = "References",
    d = "Definition",
    D = "Decleration",
    I = "Implementation",
    h = "Help doc",

    x = "Diagnostics"

    -- todo

    -- make a g1, g2, g3, etcc for window navigation?



  }
});
wk.register({
  ["<leader>\\"] = {
    name = "Terminals",

    r = { "<cmd>lua _RAILS_CONSOLE_TOGGLE()<CR>", "Rails Console (Float)" },
    a = { "<cmd>lua _START_APP_TOGGLE()<CR>", "Start App" },
    g = { "<cmd>lua _LAYGIT_TOGGLE()<CR>", "Lazygit" },
    t = { "<cmd>lua _TOGGLE_TERMINAL_DIR()<CR>", "Toggle Float"},

    c = { "<cmd>lua _TERMINAL_EOD()<CR>", "Continue"},
    x = { "<cmd>lua _TERMINAL_EOD()<CR>", "Kill"},

    p = { "<cmd>ToggleTermSendCurrentLine<CR>", "Paste Current Line"},
    v = { "<cmd>ToggleTermSendVisualSelection<CR>", "Paste Visual Selection"}
    -- p = "Rails REPL",
    -- TODO: Test
  },
  ["<leader>."] = {
    name = "Edir or something...",
  },
  ["<leader>,"] = {
    name = "Edir or something...",
  }
})

-- TODO: Settle on prefix(es) and groupings for search/find/lookup
-- leader f - first there are file find operations by name
-- leader s? or just part of f? - then file find ops by content (search)
--
-- g then there are operations based on a word, file or context
-- find references for this symbol
-- grep for this word
-- doc for this word
keymap("n", "<leader>f<space>", "<cmd>Telescope find_files<cr>", opts)
wk.register({
  -- TODO: customize list for text objects
  -- v = {
  --   name = "Visual"
  -- },
  -- y = {
  --   name = "Yank"
  -- },
  -- c = {
  --   name = "Change"
  -- },
  -- d = {
  --   name = "Delete"
  -- },

  f = {
    name = "Find",

-- keymap("n", "<leader>fc", "<cmd>Telescope termfinder find<cr>", opts)

    f = { "<cmd>Telescope find_files<cr>", "File" },
    d = { "<cmd>lua require('telescope.builtin').find_files({ previewer = false, find_command = { 'fd', '--type', 'd' }, prompt_title = 'Find in directory'})<cr>", "In Dir"},
    m = { "<cmd>Telescope lsp_document_symbols<cr>", "Method"},
    b = { "<cmd>lua require('telescope.builtin').buffers({ sort_mru = true, ignore_current_buffer = true })<cr>", "Buffer"},
    w = { "<cmd>lua require('telescope.builtin').grep_string({search = vim.fn.expand('<cword>')})<cr>", "Word"},
    s = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Search" },
    l = { "<cmd>Telescope resume<cr>", "Last Search" },
    -- ['\\'] = { "<cmd>Telescope termfinder find<cr>", "Terminal" }, -- TODO: this doesn't list any of my custom terms (which are the only ones I care about here)
    e = { "<cmd>lua vim.lsp.buf.references()<CR>", "Reference"},
    g = {
      name = "Git",
      b = { "<cmd>lua require('telescope.builtin').git_branches()<cr>", "Branches" },
      c = { "<cmd>lua require('telescope.builtin').git_commits()<cr>", "Commits" },
      f = { "<cmd>lua require('telescope.builtin').git_bcommits()<cr>", "Buffer Commits" },
      s = { "<cmd>lua require('telescope.builtin').git_stash()<cr>", "Stashes" },
    },
    r = {
      name = "Rails",
      m = { "<cmd>Telescope find_files cwd=app/models<Cr>", "Model" },
      c = { "<cmd>Telescope find_files cwd=app/controllers<Cr>", "Controller" },
      s = { "<cmd>Telescope find_files cwd=spec<Cr>", "Spec" }
    }
  },

  g = {
    name = "Git",

    -- TODO: figure out how to add a hover to show full commit message and enter to view commit diff
    b = { "<cmd>lua require('agitator').git_blame({sidebar_width=40})<CR>", "Blame"},
    v = { ":lua ShowCommitAtLine()<cr>", "View commit"},
    t = { "<cmd>lua require('agitator').git_time_machine()<CR>", "Time Machine"},
    g = "Lazygit",
    y = "Copy github link",

    h = { "<Cmd>DiffviewFileHistory %.<CR>", "History" },

    -- b = { "<Cmd>VGit buffer_blame_preview<CR>", "Blame" },
    -- d = { "<Cmd>VGit buffer_diff_preview<CR>", "Diff" },
    -- h = { "<Cmd>VGit buffer_history_preview<CR>", "History" },

    -- nnoremap('<leader>gs', '<Cmd>VGit buffer_stage<CR>')
    -- nnoremap('<leader>gr', '<Cmd>VGit buffer_reset<CR>')
    -- nnoremap('<leader>gp','<Cmd>VGit buffer_hunk_preview<CR>')
    -- nnoremap('<leader>gu','<Cmd>VGit buffer_reset<CR>')
    -- nnoremap('<leader>gg','<Cmd>VGit buffer_gutter_blame_preview<CR>')
    -- nnoremap('<leader>gl','<Cmd>VGit project_hunks_preview<CR>')
    -- nnoremap('<leader>gd','<Cmd>VGit project_diff_preview<CR>')
    -- nnoremap('<leader>gq','<Cmd>VGit project_hunks_qf<CR>')
    -- nnoremap('<leader>gx','<Cmd>VGit toggle_diff_preference<CR>')
  },
  h = {
    name = "Help / Docs",

    c = { "<cmd>lua require('telescope.builtin').commands()<cr>", "Commands" },
    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Help" },
  },
  q = {
    name = "Quickfix",

    o = { "<cmd>copen<CR>", "Open" }

  },
  r = {
    --- Testing
    name = "Run",
    n = { "<cmd>TestNearest<cr>", "Nearest"},
    N = { "<cmd>TestNearest<cr>", "Nearest (background)"},
    s = { "<cmd>TestFile<cr>", "File"},
    S = { "<cmd>TestFile<cr>", "File (background)"},
    l = { "<cmd>TestLast<cr>", "Last"},
    L = { "<cmd>TestLast<cr>", "Last (background)"},
    g = { "<cmd>TestVisit<cr>", "Goto Last Spec"}
    -- a = { "<cmd>Test", "Attach"},
    -- d = { "<cmd>Test", "Debug"},
-- TestSuite - run the whole test suite
-- TestEdit - edit tests for the current file
-- TestVisit - open the last run test in the current buffer
    -- s = {"Stop"},
    -- o = {"Overview"},
    -- p = {"Print"}
    -- keymap("n", "<leader>rf", function()
    --   require("neotest").run.run(vim.fn.expand("%"))
    -- end) -- run file
    -- keymap("n", "<leader>rn", function()
    --   require("neotest").run.run()
    -- end) -- run nearest test
    -- keymap("n", "<leader>ra", function()
    --   require("neotest").run.attach()
    -- end)
    -- keymap("n", "<leader>rd", function()
    --   require("neotest").run.run({ strategy = "dap" })
    -- end) -- debug nearest test
    -- keymap("n", "<leader>rl", function()
    --   require("neotest").run.run_last()
    -- end) -- run last test
    -- keymap("n", "<leader>rs", function()
    --   require("neotest").run.stop()
    -- end)
    -- keymap("n", "<leader>ro", function()
    --   require("neotest").summary.toggle()
    -- end)
    -- keymap("n", "<leader>rp", function()
    --   require("neotest").output.open({ enter = true })
    -- end)
  },
  s = {
    name = "?",

    -- w = "Current Word",
    -- g = "Grep"
  },
  v = {
    name = "Vim",

    c = { '<cmd>e $MYVIMRC<CR>', 'Open Config' },
    i = { '<cmd>PackerInstall<CR>', 'Install Plugins' },
    u = { '<cmd>PackerSync<CR>', 'Update Plugins' },
    r = { '<cmd>Reload<CR>', 'Reload' },
    R = { '<cmd>Restart<CR>', 'Restart' },
  }
}, { prefix = "<leader>" })
