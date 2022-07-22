local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

-- How do you take a list of results and feed them back into telescope
-- it would be usefull when there are too many results, that you then want to
-- filter based on something else (like file name/path)
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

telescope.setup {
  defaults = {
    -- prompt_prefix = " ",
    -- selection_caret = " ",
    mappings = {
      i = {
        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close
        -- ["<Down>"] = actions.cycle_history_next,
        -- ["<Up>"] = actions.cycle_history_prev,
      },
      -- n = { ["<c-q>"] = trouble.open_with_trouble }
    },
    file_ignore_patterns = {
        "nodes_modules/.*",
        "vcr_cassettes/.*",
        ".*%.snap$",
        "tags%.temp$",
    }
  },
  pickers = {
    live_grep = {
      only_sort_text = true
    },
    find_files = {
      mappings = {
        i = {
          ["<CR>"] = function(prompt_bufnr)
            local picker = action_state.get_current_picker(prompt_bufnr)
            if picker.prompt_title == "Find in directory" then
              local selection = require("telescope.actions.state").get_selected_entry()
              local dir = vim.fn.fnamemodify(selection.path, ":p:h")
              actions.close(prompt_bufnr)

              require('telescope.builtin').find_files({ cwd = dir })
            else
              actions.select_default(prompt_bufnr)
            end
          end,

          ["<c-s>"] = function(prompt_bufnr)
            local picker = action_state.get_current_picker(prompt_bufnr)
            if picker.prompt_title == "Find in directory" then
              local selection = require("telescope.actions.state").get_selected_entry()
              local dir = vim.fn.fnamemodify(selection.path, ":p:h")
              actions.close(prompt_bufnr)

              require('telescope.builtin').live_grep({ cwd = dir, prompt_title = "Grep in " .. selection.value })
            end
          end
        }
      }
    }
  }
}

telescope.load_extension('fzf')
telescope.load_extension("termfinder")
telescope.load_extension("ui-select")
telescope.load_extension("file_browser")
