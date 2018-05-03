" TODO:
" - autocomplete
" - text objects

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

set nocompatible
call plug#begin()
  Plug 'iCyMind/NeoSolarized'
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'

  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'itchyny/vim-cursorword'
  Plug 'mhinz/vim-grepper'
  Plug 'MattesGroeger/vim-bookmarks'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'

  Plug 'vim-ruby/vim-ruby'

  Plug 'w0rp/ale'
  let g:ale_linters = {'javascript': ['flow', 'eslint']}

  Plug 'cakebaker/scss-syntax.vim'
  Plug 'hail2u/vim-css3-syntax'

  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'elzr/vim-json'
  let g:javascript_plugin_flow = 1
  let g:vim_jsx_pretty_colorful_config = 1
  Plug 'peterhoeg/vim-qml'

  Plug 'benmills/vimux'
  Plug 'skalnik/vim-vroom'
call plug#end()

syntax enable
set encoding=utf-8

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nojoinspaces

" Searching
set gdefault
set hlsearch
set incsearch
set showmatch
set ignorecase
set smartcase
nmap N Nzz
nmap n nzz

set termguicolors
colorscheme NeoSolarized
set background=dark
let g:neosolarized_contrast = "high"
let g:lightline = {
			\ 'colorscheme': 'solarized',
			\ 'active': {
			\   'right': [['lineinfo'], ['percent'], ['filetype']]
			\ }}
let g:lightline.component_expand = {
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \ }

let g:lightline.active = { 'right': [ ['lineinfo'], ['percent'], ['filetype'], [ 'linter_errors', 'linter_warnings', 'linter_ok' ]] }

set noshowmode

set clipboard=unnamed

let mapleader=' '

" Absolute line numbers in insert mode, and relative in normal mode
set number relativenumber
autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set number relativenumber

" Switch between files with leader-leader
nnoremap <leader><leader> <c-^>

" Switch panes without <c-w> prefix
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

nnoremap <leader>t :Files<Cr>
nnoremap <leader>m :BTags<Cr>
nnoremap <leader>b :Buffers<Cr>
nnoremap <C-p>m :Files app/models<Cr>
nnoremap <C-p>c :Files app/controllers<Cr>
nnoremap <C-p>j :Files ui<Cr>
nnoremap <C-p>s :Files spec<Cr>

nmap <leader>/ <plug>CommentaryLine<CR>
vmap <leader>/ <plug>Commentary<CR>
nmap <leader>w :wa<cr>

" retain visual selection on < or > indent commands
vnoremap > >gv
vnoremap < <gv

" Select last pasted block
nnoremap gp `[v`]

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" If a quickfix, or help window is open close it, independent of what pane
" has focus, otherwise close the current pane
fu! CloseQuickFixOrBuffer()
    for i in range(1, winnr('$'))
        let bnum = winbufnr(i)
        if getbufvar(bnum, '&buftype') == 'quickfix'
            cclose
            return
        endif
    endfor
    :q
endfunction
nmap <leader>c :call CloseQuickFixOrBuffer()<cr>

runtime plugin/grepper.vim
let g:grepper.highlight = 1
let g:grepper.dir = 'repo,cwd'
let g:grepper.tools = ['rg', 'ag', 'ack', 'git']

nmap <leader>F :Grepper<cr>
nnoremap <leader>f :Grepper -tool ag -cword -noprompt<cr>

" Open a replace command for the current word
nmap <leader>r :%s/<C-r><C-w>//c<Left><Left>
" Project wide search & replace for the current word
nmap <leader>R :Qdo %s/<C-r><C-w>//gc | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
vmap <C-R> :Qdo %s/<C-r><C-w>//gc | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>

" Cycle through lines in the quickfix list
nmap <leader>j :w<CR>:cn<CR>
nmap <leader>k :w<CR>:cp<CR>
" Cycle through files in the quickfix list
nmap <leader>J :w<CR>:cN<CR>
nmap <leader>K :w<CR>:cP<CR>

" Fugitve {
  nmap <leader>gb :Gblame<CR>
  nmap <leader>gs :Gstatus<CR>
  nmap <leader>gd :Gdiff<CR>
  nmap <leader>gl :Glog<CR>
  nmap <leader>gc :Gcommit<CR>
  nmap <leader>gp :Git push<CR>
" }


let g:vroom_map_keys = 0
let g:vroom_detect_spec_helper = 1
let g:vroom_use_vimux = 1

" this should only run for ruby
nmap <leader>e :VroomRunNearestTest<CR>
nmap <leader>s :VroomRunTestFile<CR>

fu! VimuxRunLastCommandOrLastInHistory()
  if exists("g:VimuxRunnerIndex")
    call VimuxRunLastCommand()
  else
    call TmuxRun('!!')
    call VimuxSendKeys("Enter")
  endif
endfu
nmap <leader>l :call VimuxRunLastCommandOrLastInHistory()<CR>

function! TmuxRun(cmd)
  if exists("g:VimuxRunnerIndex")
    call VimuxSendText(a:cmd)
    call VimuxSendKeys("Enter")
  else
    call VimuxRunCommand(a:cmd)
  end
endfunction

function! TmuxCommand()
  call inputsave()
  let replacement = input('Sent to tmux pain:')
  call inputrestore()
  call TmuxRun(replacement)
endfunction

function! VimuxReload()
  call TmuxRun("load '".expand("%")."'")
endfunction

function! CurrentLine()
  let line = line(".")
  let file = expand("%")
  return file . ':' . line
endfunction

nnoremap <leader>,l :call VimuxReload()<CR>
