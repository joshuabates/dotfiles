" TODO:
" - Ctrlp for changes
" - Ctrlp for jumps

" - get tags working in coffeescript
" - test quickfix rspec stuff out

" - Get snippets + autocomplete working properly

" Plugins {
  set nocompatible
  call plug#begin()

  Plug 'altercation/vim-colors-solarized'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " ctrlp
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'JazzCore/ctrlp-cmatcher', { 'do': './install.sh' }
  Plug 'fisadev/vim-ctrlp-cmdpalette'
  Plug 'ivalkeen/vim-ctrlp-tjump'
  Plug 'ompugao/ctrlp-history'
  Plug 'tacahiroy/ctrlp-funky'
  Plug 'ompugao/ctrlp-locate'
  Plug 'sgur/ctrlp-extensions.vim'
    let g:ctrlp_locate_keymap_trigger_command = "<C-n>"
    let g:ctrlp_extensions = ['funky']
    let g:ctrlp_map = '<leader>t'
    let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
    let g:ctrlp_match_window = 'bottom,order:btt, max:35'
    let g:ctrlp_working_path_mode = 0
    let g:ctrlp_follow_symlinks = 2
    let g:ctrlp_funky_syntax_highlight = 1
    let g:ctrlp_status_func = {'main': 'CtrlpStatus', 'prog': 'CtrlpStatus' }
    let g:ctrlp_tjump_only_silent = 1
    fu! CtrlpStatus()
      return ''
    endfu

  " Autocompletion and Snippets
  Plug 'SirVer/ultisnips'
  Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_auto_trigger = 0
    " let g:ycm_key_invoke_completion = '<C-n>'
    let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_key_detailed_diagnostics = ''
    let g:UltiSnipsExpandTrigger = "<tab>"
    let g:UltiSnipsJumpForwardTrigger = "<tab>"
    let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

    function! g:SnippetOrComplete()
      call UltiSnips#ExpandSnippetOrJump()
      if g:ulti_expand_or_jump_res == 0
        if pumvisible()
          return "\<C-N>"
        else
          if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
          " if getline('.')[0:col('.')-1]
            return "\<C-X>\<C-U>\<C-P>"
          else
            return "\<tab>"
          end
        endif
      endif

      return ""
      endif
    endfunction

    function! g:UltiSnips_Reverse()
      call UltiSnips#JumpBackwards()
      if g:ulti_jump_backwards_res == 0
        return "\<C-P>"
      endif

      return ""
    endfunction

    "Use TAB to complete when typing words, else inserts TABs as usual.
    function! Tab_Or_Complete()
      if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
        return "\<C-N>"
      else
        return "\<Tab>"
      endif
    endfunction
    inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>

    au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:SnippetOrComplete()<cr>"
    au BufEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"

  Plug 'scrooloose/syntastic'
  let g:syntastic_mode_map = { 'passive_filetypes': ['sass'] }

  Plug 'sjl/gundo.vim'

  " TODO: Fix incompatibility with my nzz remap
  " Plug 'henrik/vim-indexed-search'
  " Plug 'rking/ag.vim'
  Plug 'mileszs/ack.vim'
  let g:agprg = 'ag --nogroup --nocolor --column --smart-case'
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  Plug 'matchit.zip'

  Plug 'justinmk/vim-sneak'
  let g:sneak#streak = 1

  augroup SneakPluginColors
    autocmd!
    autocmd ColorScheme * hi SneakPluginTarget guifg=black guibg=red ctermfg=black ctermbg=red
    autocmd ColorScheme * hi SneakStreakTarget guifg=black guibg=red ctermfg=black ctermbg=red
    autocmd ColorScheme * hi SneakPluginScope  guifg=black guibg=yellow ctermfg=black ctermbg=yellow
    autocmd ColorScheme * hi SneakStreakMask  guifg=black guibg=yellow ctermfg=black ctermbg=yellow
  augroup END

  Plug 'kana/vim-textobj-user'
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Ruby text objects
  " ir/ar - any ruby block (if, do ,def , etc)
  " id/ad - ruby method, class, or module
  Plug 'rhysd/vim-textobj-ruby'
  Plug 'lucapette/vim-textobj-underscore'
  Plug 'vim-indent-object'
  Plug 'godlygeek/tabular'
  Plug 'wellle/targets.vim'

  Plug 'repmo.vim'
  let g:repmo_mapmotions = "j|k h|l"


  Plug 'AndrewRadev/splitjoin.vim'

  Plug 'bitc/vim-bad-whitespace'
  Plug 'henrik/vim-qargs'

  " Send commands to tmux panes
  " Plug 'yunake/vimux'
  Plug 'benmills/vimux'
  let g:VimuxOrientation = "h"
  let VimuxUseNearestPane = 1
  " let g:VimuxTmuxCommand = "tmate"
  let g:VimuxTmuxCommand = "tmux"

  Plug 'christoomey/vim-tmux-navigator'
  Plug 'skalnik/vim-vroom'
  let g:vroom_use_vimux = 1
  let g:vroom_map_keys = 0
  let g:vroom_use_spring = 1
  let g:vroom_use_colors = 0
  let g:vroom_rspec_version = 'x' " trick vroom into suppressing the no-color flag

  " Plug 'matze/vim-move'
  " let g:move_key_modifier = 'C'

  Plug 'vim-ruby/vim-ruby'
  Plug 'jgdavey/vim-blockle'
  let g:blockle_mapping = '<Leader>{'

  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-cucumber'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-haml'

  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-markdown'
  Plug 'tpope/vim-rsi'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " vim-abolish
  "
  " Work with variants of a word: search/replace, abbreviations.
  " Also adds coercion:
  " crs snake_case
  " crm MixedCase
  " crc camelCase
  " cru UPPER_CASE
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-repeat'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " vim-vinegar
  "
  " netrw fixes to make it better. Press - in normal mode.
  " Use ,w to get back.
  " Use - to go up a directory.
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  Plug 'tpope/vim-vinegar'

  Plug 'pangloss/vim-javascript'
  Plug 'othree/vim-jsx'
  :let g:jsx_ext_required = 0

  Plug 'kchmck/vim-coffee-script'

  Plug 'guns/vim-clojure-static'
  Plug 'tpope/vim-fireplace'

  Plug 'rizzatti/dash.vim'
  nmap <silent> <leader>d <Plug>DashSearch
  vmap <silent> <leader>d "dy:Dash <C-R>d<CR>

  call plug#end()
" }

set ruler
syntax on

" Absolute line numbers in insert mode, and relative in normal mode
	set number relativenumber
	autocmd InsertEnter * :set number norelativenumber
	autocmd InsertLeave * :set number relativenumber

let mapleader=' '
set notimeout
set ttimeout

" Don't wait so long for the next keypress (particularly in ambigious Leader situations. (via @r00k dotfiles)
set timeoutlen=500
set ttimeoutlen=10

" Switch between files with leader-leader
nnoremap <leader><leader> <c-^>

" Switch panes without <c-w> prefix
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

nnoremap <leader>m :CtrlPFunky<Cr>
command! FindNotes :CtrlP ~/Dropbox/Docs/Notes/

nnoremap <C-p>: :CtrlPCmdPalette<cr>
nnoremap <C-p>; :CtrlPCmdPalette<cr>
nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>
nnoremap <silent><C-p>h :CtrlPCmdHistory<CR>
nnoremap <silent><C-p>/ :CtrlPSearchHistory<CR>
nnoremap <c-p>y :CtrlPYankring<cr>
nnoremap <C-p>b :CtrlPBuffer<cr>
nnoremap <leader>b :CtrlPBuffer<cr>
nnoremap <C-p>f :CtrlPLocate<cr>

" SlitJoin {
  nnoremap gj :SplitjoinSplit<cr>
  nnoremap gk :SplitjoinJoin<cr>
  let g:splitjoin_ruby_curly_braces=0
" }

let g:targets_pairs = '() {} [] <>'

" Looks {
  color solarized
  set background=dark
  set winwidth=84
  set showmode                  " display the current mode
  set cursorline " highlight current line
  hi! VertSplit ctermbg=0 guibg=Grey40
" }

let loaded_matchparen=1 " Don't load matchit.vim (paren/bracket matching)
set noshowmatch         " Don't match parentheses/brackets
set nocursorcolumn      " Don't paint cursor column
set lazyredraw          " Wait to redraw
set scrolljump=8        " Scroll 8 lines at a time at bottom/top
let html_no_rendering=1 " Don't render italic, bold, links in HTML

let g:syntastic_enable_signs=1
let g:syntastic_quiet_messages = {'level': 'warnings'}

" Open undo tree buffer
nnoremap <Leader>u :GundoToggle<CR>

set clipboard=unnamed

" Commentary {
  nmap <leader>/ <plug>CommentaryLine<CR>
  vmap <leader>/ <plug>Commentary<CR>
" }

" Fugitve {
  nmap <leader>gb :Gblame<CR>
  nmap <leader>gs :Gstatus<CR>
  nmap <leader>gd :Gdiff<CR>
  nmap <leader>gl :Glog<CR>
  nmap <leader>gc :Gcommit<CR>
  nmap <leader>gp :Git push<CR>
" }

" CTags
" Retag all files in project
map <leader>rt :!ctags --extra=+f -R *<CR><CR>
" au BufWritePost *.rb silent! !ctags --extra=+f -R &
map <C-\> :tnext<CR>

" MatchIt
" % to bounce from do to end etc.
runtime! macros/matchit.vim

" Set encoding
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

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Use modeline overrides
set modeline
set modelines=10

" set winminheight=0
" set winheight=999

" Directories for swp files
set backupdir=/tmp
set directory=/tmp

nnoremap <leader>h :h <c-r><c-w><CR>

" Autoreload when .vimrc files change
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" Save with leader-w
nmap <leader>w :wa<cr>

map <F1> <nop>

" retain visual selection on < or > indent commands
vnoremap > >gv
vnoremap < <gv

" Select last pasted block
nnoremap gp `[v`]

" When on, the ":substitute" flag 'g' is default on.  This means that
" all matches in a line are substituted instead of one.
set gdefault
" When a bracket is inserted, briefly jump to the matching one.  The
" jump is only done if the match can be seen on the screen.  The time to
" show the match can be set with 'matchtime'.
set showmatch

"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

function! s:VSetSearch(cmdtype)
  let temp = @s
  norm! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

nmap <leader>F :Ack!<space>
nmap <leader>f :Ack! <C-r><C-w><cr>

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

let g:netrw_browse_split=0
cabbrev E Explore
cabbrev ej e app/assets/javascripts

fu! VimuxRunLastCommandOrLastInHistory()
  if exists("g:VimuxRunnerIndex")
    call VimuxRunLastCommand()
  else
    call TmuxRun('!!')
    call VimuxSendKeys("Enter")
  endif
endfu

nmap <leader>l :call VimuxRunLastCommandOrLastInHistory()<CR>

" Copy current path to clipboard
nmap <leader>g :let @*=expand(@%).":".line(".")<CR>

" EXPERIMENTAL IN FLUX STUFF {
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

  function! TmuxSelectRepl()
    call system('tmux select-pane -t :.+')
  endfunction

  function! CurrentLine()
    let line = line(".")
    let file = expand("%")
    return file . ':' . line
  endfunction

  nmap <plug>ReplCopyLastSelection gv<plug>ReplCopySelection
  nmap <plug>ReplCopyLine "ryy :call TmuxRun(@r)<CR>j :call repeat#set("\<plug>ReplCopyLine")<cr>
  vmap <plug>ReplCopySelection "ry :call TmuxRun(@r)<CR>

  vmap <C-,> <plug>ReplCopySelection
  nmap <leader>,p <plug>ReplCopyLine
  nmap <leader>,. <plug>ReplCopyLastSelection
  nmap <leader>,c :call TmuxRun('c')<CR>
  nmap <leader>,n :call TmuxRun('n')<CR>
  nmap <leader>,s :call TmuxRun('s')<CR>
  nmap <leader>,d :call TmuxRun('^d')<CR>
  nmap <leader>,os :call TmuxRun('page.save_and_open_screenshot(nil, full: true)')<CR>
  nmap <leader>,op :call TmuxRun('page.save_and_open_page')<CR>
  nmap <leader>,t :call TmuxCommand()<CR>
  nmap <leader>,b :call TmuxRun('break ' . CurrentLine())<CR>

  nnoremap <leader>,l :call VimuxReload()<CR>

  " Select current paragraph and send it to tmux
  nmap <leader>,s vip<leader>pp<CR>

  " Nab lines from ~/.pry_history (respects "count")
  nmap <Leader>,h :<c-u>let pc = (v:count1 ? v:count1 : 1)<cr>:read !tail -<c-r>=pc<cr> ~/.pry_history<cr>:.-<c-r>=pc-1<cr>:norm <c-r>=pc<cr>==<cr>

" }

" Compatibilty with other engineers
imap jk <Esc>
imap kj <Esc>
nmap <C-p> :CtrlP<cr>
