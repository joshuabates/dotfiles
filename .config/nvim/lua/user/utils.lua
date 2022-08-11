local M = {}
local fn = vim.fn

M.file_exists = function(path)
  local f = io.open(path, "r")
  if f ~= nil then io.close(f) return true else return false end
end

M.starts_with = function(str, start)
  return str:sub(1, #start) == start
end

M.split = function(s, delimiter)
  local result = {}
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match)
  end

  return result
end

M.handle_job_data = function(data)
  if not data then
    return nil
  end
  if data[#data] == "" then
    table.remove(data, #data)
  end
  if #data < 1 then
    return nil
  end
  return data
end

M.log = function(message, title)
  require('notify')(message, "info", { title = title or "Info" })
end

M.warnlog = function(message, title)
  require('notify')(message, "warn", { title = title or "Warning" })
end

M.errorlog = function(message, title)
  require('notify')(message, "error", { title = title or "Error" })
end

M.with_cursor_restore = function(fn)
  return function(...)
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local winnr = vim.api.nvim_get_current_win()

    fn(...)

    vim.api.nvim_win_set_cursor(winnr, { line, col })
  end
end

return M
