function! g:TeaspoonSpec()
  call g:ExecrusShell(g:RunSpringCmd('teaspoon', expand("%")))
endfunction

function! g:RunSpringCmd(cmd, path)
  let cmd = a:cmd . ' ' . a:path

  if (g:SpringAvailable())
    let cmd = 'spring ' . cmd
  endif

  return cmd
endfunction

function! g:SpringAvailable()
  if !filereadable("config/application.rb") || empty(system("which spring"))
    return 0
  endif
  return 1

  let cmd = "spring " . a:framework . " "
endfunction

" call g:AddExecrusPlugin({
"   \'name': 'Teaspoon',
"   \'exec': function("g:TeaspoonSpec"),
"   \'cond': '_spec.js.coffee$',
"   \'prev': 'Default Coffee',
"   \})
