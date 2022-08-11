
-- command! CreateStyles call CreateStyles()
-- function! CreateStyles()
--   let l:basePath=expand('%:r')
--   let l:baseName=expand('%:t:r')
--   let l:cssFile=l:basePath.".scss"
--   exec 'normal oimport styles from "./'.l:baseName.'.scss";'
--   exec 'vsp '.l:cssFile
-- endfunction
--

function CloseQuickFixOrBuffer()
  local window_count = vim.fn.winnr("$")
  for win_num = 1,window_count do
    local win = vim.fn.win_getid(win_num)
    local bnum = vim.fn.winbufnr(win_num)
    local type = vim.fn.getbufvar(bnum, '&buftype')
    local ftype = vim.fn.getbufvar(bnum, '&filetype')

    if not vim.api.nvim_win_get_config(win).relative == "" then
      vim.api.nvim_win_close(win, 0)
    elseif type == 'quickfix' then
      vim.cmd("cclose")
      return
    elseif type == 'help' then
      vim.cmd("helpc")
      return
    elseif ftype == 'GitBlame' then
      pcall(function()
        vim.api.nvim_win_close(win, 0)
      end)
      return
    -- elseif type == 'terminal' then
    --   vim.cmd("close")
    --   return
    end
  end

  pcall(function()
    vim.api.nvim_win_close(0, 0)
  end)
end
