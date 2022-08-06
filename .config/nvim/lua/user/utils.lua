local M = {}

M.with_cursor_restore = function(fn)
  return function(...)
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local winnr = vim.api.nvim_get_current_win()

    fn(unpack(arg))

    vim.api.nvim_win_set_cursor(winnr, { line, col })
  end
end

return M
