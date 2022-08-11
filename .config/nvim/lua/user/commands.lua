
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

    if type == 'quickfix' then
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
-- function ToggleTroubleAuto()
--   print("AUTO MAG")
--   local buftype = "quickfix"
--   if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
--     print("LOCL")
--     buftype = "loclist"
--   end
--
--   local ok, trouble = pcall(require, "trouble")
--   if ok then
--     s, v = pcall(function()
--       return vim.api.nvim_win_close(0, true)
--     end)
--
--     print("OK TRY TO CLOSE")
--     print("DID CLOSE")
--     trouble.open(buftype)
--     print("DID TOGGLE")
--   else
--     print("NO OK")
--     local set = vim.opt_local
--     set.colorcolumn = ""
--     set.number = false
--     set.relativenumber = false
--     set.signcolumn = "no"
--   end
-- end
