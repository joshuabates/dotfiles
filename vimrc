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
  Plug 'morhetz/gruvbox'
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'

  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'knubie/vim-kitty-navigator', { 'commit': '08a792' }
  Plug 'itchyny/vim-cursorword'
  Plug 'mhinz/vim-grepper'
  Plug 'MattesGroeger/vim-bookmarks'

  Plug 'ludovicchabant/vim-gutentags'

  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'tpope/vim-abolish' " crs (snake), crm (mixed), crc (camel), cru (upper), cr- (dash), cr. (dot) cr<space> (space), crt (title)
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-eunuch'

  Plug 'andrewradev/switch.vim' " gs
  Plug 'AndrewRadev/splitjoin.vim' " gS gJ

  Plug 'jgdavey/vim-blockle'
  let g:blockle_mapping = '<Leader>{'
  Plug 'vim-ruby/vim-ruby'

  Plug 'w0rp/ale'
  let g:ale_linters = {'javascript': ['flow', 'eslint']}
  let g:ale_fixers = {'javascript': ['eslint']}

  Plug 'cakebaker/scss-syntax.vim'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'ap/vim-css-color'

  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  " Plug 'suy/vim-context-commentstring'
  " let g:context#commentstring#table['javascript'] = {
			" \ 'jsComment' : '// %s',
			" \ 'jsImport' : '// %s',
			" \ 'jsxStatment' : '// %s',
			" \ 'jsxRegion' : '{/*%s*/}',
  "     \}
  let g:jsx_ext_required = 0

  Plug 'mattn/emmet-vim'
  let g:user_emmet_settings = {
        \  'javascript' : {
        \      'extends' : 'jsx',
        \  },
        \}

  Plug 'elzr/vim-json'
  let g:javascript_plugin_flow = 1
  let g:vim_jsx_pretty_colorful_config = 1

  " autocmd FileType javascript set formatprg=prettier\ --stdin
  " autocmd BufWritePre *.js :normal gggqG

  Plug 'peterhoeg/vim-qml'

  Plug 'janko/vim-test'

  Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
  " Plug 'neoclide/coc-solargraph', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
  " Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'} " mru and stuff
  " Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'} " color highlighting
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
nnoremap Q <Nop>

set termguicolors
colorscheme gruvbox
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

autocmd bufwritepost .vimrc source $MYVIMRC

" Switch between files with leader-leader
nnoremap <leader><leader> <c-^>


nnoremap <leader>t :call fzf#vim#files('', fzf#vim#with_preview({'options': '--prompt ""'}, 'right:50%'))<CR>
" nnoremap <leader>t :Files<Cr>
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
        let type = getbufvar(bnum, '&buftype')
        if type == 'quickfix'
            cclose
            return
        endif
        if type == 'terminal'
            execute "Tclose"
            return
        endif
    endfor
    :q
endfunction
nmap <leader>c :call CloseQuickFixOrBuffer()<cr>

let $FZF_DEFAULT_OPTS=' --color=dark --layout=reverse --margin=1,4'
" let $FZF_DEFAULT_OPTS=' --color=dark --color=fg:15,bg:-1,hl:1,fg+:#ffffff,bg+:0,hl+:1 --color=info:0,prompt:0,pointer:12,marker:4,spinner:11,header:-1 --layout=reverse --margin=1,4'
"
autocmd BufLeave *#FZF :bd!
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(40)
  let width = float2nr(120)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

runtime plugin/grepper.vim
let g:grepper.highlight = 1
let g:grepper.dir = 'repo,cwd'
let g:grepper.tools = ['rg', 'ag', 'ack', 'git']

nmap <leader><C-F> :Ag<cr>
nmap <leader>F :GrepperAg 
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

nmap <leader>e :TestNearest<CR>
nmap <leader>s :TestFile<CR>
nmap <leader>l :TestLast<CR>
nmap <leader>L :TestVisit<CR>
let test#strategy = "kitty"
tnoremap <Esc> <C-\><C-n>
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-l> <C-\><C-n><C-w>l

let current_node_path = trim(system('asdf where nodejs 14.4.0'))
let g:coc_node_path = current_node_path . '/bin/node'
" fu! VimuxRunLastCommandOrLastInHistory()
"   if exists("g:VimuxRunnerIndex")
"     call VimuxRunLastCommand()
"   else
"     call TmuxRun('!!')
"     call VimuxSendKeys("Enter")
"   endif
" endfu
" nmap <leader>l :call VimuxRunLastCommandOrLastInHistory()<CR>

" function! TmuxRun(cmd)
"   if exists("g:VimuxRunnerIndex")
"     call VimuxSendText(a:cmd)
"     call VimuxSendKeys("Enter")
"   else
"     call VimuxRunCommand(a:cmd)
"   end
" endfunction

" function! TmuxCommand()
"   call inputsave()
"   let replacement = input('Sent to tmux pain:')
"   call inputrestore()
"   call TmuxRun(replacement)
" endfunction

" function! VimuxReload()
"   call TmuxRun("load '".expand("%")."'")
" endfunction

" function! CurrentLine()
"   let line = line(".")
"   let file = expand("%")
"   return file . ':' . line
" endfunction

" nnoremap <leader>,l :call VimuxReload()<CR>
