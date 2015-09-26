vmap <leader>C <esc>:'<,'>:CoffeeCompile vert<CR>
map <leader>C :CoffeeCompile vert<CR>
command! -nargs=1 C CoffeeCompile | :<args>
setl foldmethod=indent nofoldenable

omap ib ii
omap ab ai
xmap ib ii
xmap ab ai

onoremap im :<c-u>call <SID>FunctionTextObject('i')<cr>
onoremap am :<c-u>call <SID>FunctionTextObject('a')<cr>
xnoremap im :<c-u>call <SID>FunctionTextObject('i')<cr>
xnoremap am :<c-u>call <SID>FunctionTextObject('a')<cr>
function! s:FunctionTextObject(type)
  let function_start = search('.*\((.\{-})\)\=\s*[-=]>$', 'Wbc')
  if function_start <= 0
    return
  endif

  let body_start = function_start + 1
  if body_start > line('$') || indent(nextnonblank(body_start)) <= indent(function_start)
    if a:type == 'a'
      normal! vg_
    endif

    return
  endif

  let indent_limit = s:LowerIndentLimit(body_start)

  if a:type == 'i'
    let start = body_start
  else
    let start = function_start
  endif

  call s:MarkVisual('v', start, indent_limit)
endfunction

function! s:LowerIndentLimit(lineno)
  let base_indent  = indent(a:lineno)
  let current_line = a:lineno
  let next_line    = nextnonblank(current_line + 1)

  while current_line < line('$') && indent(next_line) >= base_indent
    let current_line = next_line
    let next_line    = nextnonblank(current_line + 1)
  endwhile

  return current_line
endfunction

function! s:UpperIndentLimit(lineno)
  let base_indent  = indent(a:lineno)
  let current_line = a:lineno
  let prev_line    = prevnonblank(current_line - 1)

  while current_line > 0 && indent(prev_line) >= base_indent
    let current_line = prev_line
    let prev_line    = prevnonblank(current_line - 1)
  endwhile

  return current_line
endfunction

function! s:MarkVisual(command, start_line, end_line)
  if a:start_line != line('.')
    exe a:start_line
  endif

  if a:end_line > a:start_line
    exe 'normal! '.a:command.(a:end_line - a:start_line).'jg_'
  else
    exe 'normal! '.a:command.'g_'
  endif
endfunction
