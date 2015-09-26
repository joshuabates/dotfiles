set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_rails = 1
let g:rubycomplete_classes_in_global = 1
nnoremap <leader>a :A<CR>  " Go to alternate file
" Alternate between do; end and { } blocks in ruby
nmap <leader>{ $<Plug>BlockToggle

nmap <Leader>s :VroomRunTestFile<CR>
nmap <Leader>e :VroomRunNearestTest<CR>
nmap <Leader>T :VroomRunTestFile<CR>

if !exists("*LoadAndDisplayRSpecQuickfix")
  function! LoadAndDisplayRSpecQuickfix()
    let quickfix_filename = "tmp/rspec_quickfix.out"
    if filereadable(quickfix_filename) && getfsize(quickfix_filename) != 0
      silent execute ":cgetfile " . quickfix_filename
      botright cwindow
    else
      redraw!
      echohl WarningMsg | echo "Quickfix file " . quickfix_filename . " is missing or empty." | echohl None
    endif
  endfunction
endif

noremap <Leader>q :call LoadAndDisplayRSpecQuickfix()<CR>

call textobj#user#plugin('ruby', {
      \
      \ 'any' : {
      \      'select-a' : 'ab', '*select-a-function*' : 'textobj#ruby#any_select_a',
      \      'select-i' : 'ib', '*select-i-function*' : 'textobj#ruby#any_select_i',
      \   },
      \
      \ 'definition' : {
      \      'select-a' : 'am', '*select-a-function*' : 'textobj#ruby#object_definition_select_a',
      \      'select-i' : 'im', '*select-i-function*' : 'textobj#ruby#object_definition_select_i',
      \   }
      \ })

nnoremap <leader>a :A<CR>  " Go to alternate file

map <C-p>v :CtrlP app/views/<cr>
map <C-p>c :CtrlP app/controllers/<cr>
map <C-p>m :CtrlP app/models/<cr>
map <C-p>j :CtrlP app/assets/javascripts/<cr>
map <C-p>f :CtrlP features/<cr>
map <C-p>s :CtrlP spec/<cr>

nmap <silent> <leader>d <Plug>DashSearch
vmap <silent> <leader>d "dy:Dash <C-R>d<CR>
