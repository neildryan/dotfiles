"************************************************************************
"" Vim-Plug core
"************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

if has('nvim')
    let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
    if !filereadable(vimplug_exists)
      echo "Installing Vim-Plug..."
      echo ""
      silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
         \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      let g:not_finish_vimplug = "yes"

      autocmd VimEnter * PlugInstall
    endif
    " Required:
    call plug#begin(expand('~/.config/nvim/plugged'))
else
    let vimplug_exists=expand('~/.vim/autoload/plug.vim')
    if !filereadable(vimplug_exists)
      echo "Installing Vim-Plug..."
      echo ""
      silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs
         \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      let g:not_finish_vimplug = "yes"

      autocmd VimEnter * PlugInstall
    endif
    " Required:
    call plug#begin(expand('~/.vim/plugged'))
endif

"************************************************************************
"" Plug install packages
"************************************************************************

if has('nvim')
    Plug 'neomake/neomake'
else
    Plug 'scrooloose/syntastic'
endif


Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'sheerun/vim-polyglot'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'embear/vim-localvimrc'
Plug 'junegunn/goyo.vim'

let g:make = 'gmake'
if exists('make')
        let g:make = 'make'
endif
Plug 'Shougo/vimproc.vim', {'do': g:make}

"" Color
Plug 'tomasr/molokai'
Plug 'joshdick/onedark.vim'
Plug 'KeitaNakamura/neodark.vim'

call plug#end()


"*************************************************************************
"" Basic Setup
"*************************************************************************
" Required:
filetype plugin indent on

"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
if !has('nvim')
    set ttyfast
endif

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"" Map leader
let mapleader=' '

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup
set noswapfile

set fileformats=unix,dos,mac
set showcmd

set shortmess=atI

" % matches if/else and others
runtime macros/matchit.vim

" session management
if has('nvim')
    let g:session_directory = "~/.config/nvim/session"
else
    let g:session_directory = "~/.vim/session"
endif

let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"************************************************************************
"" Visual Settings
"************************************************************************
syntax on
set ruler

let no_buffers_menu=1
if !exists('g:not_finish_vimplug')
"  colorscheme molokai
   colorscheme onedark
   let g:onedark_termcolors=16
   set background=light
endif


set t_Co=256
set gfn=Monospace\ 10

if !has('nvim')
    if $COLORTERM == 'gnome-terminal'
        set term=gnome-256color
    else
        if $TERM == 'xterm'
            set term=xterm-256color
        endif
    endif

    if &term =~ '256color'
        set t_ut=
    endif
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

set title
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" vim-airline
let g:airline_theme = 'powerlineish'
if has('nvim')
    let g:airline#extensions#syntastic#enabled = 0
else
    let g:airline#extensions#syntastic#enabled = 1
endif

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

let g:airline#extensions#virtualenv#enabled = 1
set ttimeoutlen=50

"" Disable visualbell
set noerrorbells visualbell t_vb=

"*********************************************************************
"" Abbreviations
"*********************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" terminal emulation
if has('nvim')
  " vimshell.vim
  let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_prompt =  '$ '
  nnoremap <silent> <leader>sh :terminal<CR>
else
    nnoremap <silent> <leader>sh :VimShellCreate<CR>
endif

"*********************************************************************
"" Functions
"*********************************************************************
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

"*********************************************************************
"" Autocmd Rules
"*********************************************************************
"" PC fast enough, do syntax hi syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

"" txt
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt,*.tex call s:setupWrapping()
augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"************************************************************************
"" Mappings
"************************************************************************

"" Line numbers - default off
noremap <Leader>n :set invrelativenumber<CR> :set invnumber<CR>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Switching windows
noremap <Leader>j <C-w>j
noremap <Leader>k <C-w>k
noremap <Leader>l <C-w>l
noremap <Leader>h <C-w>h

"" Git
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>

"" Syntastic
if !has('nvim')
    noremap <Leader>c :SyntasticCheck<CR>
    noremap <Leader>r :SyntasticReset<CR>
    noremap <Leader>i :SyntasticInfo<CR>
endif

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :CloseSession<CR>

"" Tabs
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <Leader>w :bdelete<CR>

"" Opens an edit command with path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_open_new_file = 't' "TODO, maybe buffer?
let g:ctrlp_follow_symlinks = 1 " Follow but avoid recursive
let g:cctrlp_brief_prompt = 1 "<bs> on empty prompt exits

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
nnoremap <silent> <F2> :NERDTreeFind<CR>
noremap <F3> :NERDTreeToggle<CR>

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" syntastic
if !has('nvim')
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_style_error_symbol = '✗'
    let g:syntastic_style_warning_symbol = '⚠'
    let g:syntastic_auto_loc_list=1
    let g:syntastic_aggregate_errors = 1
endif

" Neomake
if has('nvim')
    "autocmd! BufWritePost,BufEnter * Neomake " Run on read/write
    let g:neomake_open_list = 2 " Auto-open error window
    let g:neomake_error_sign = {
                \ 'text': '✗',
                \ 'texthl': 'WarningMsg',
                \ }
    let g:neomake_warning_sign = {
                \ 'text': '⚠',
                \ 'texthl': 'ErrorMsg',
            \ }
endif

" vim-localvimrc
let g:localvimrc_name = [".lvimrc"]
let g:localvimrc_event = ["BufWinEnter", "BufEnter"]
let g:localvimrc_sandbox = 0

" Disable visualbell
set noerrorbells visualbell t_vb=

"" Copy/Paste/Cut
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"***********************************************************************
"" Custom configs
"***********************************************************************

" c
autocmd FileType c setlocal tabstop=4 shiftwidth=4 expandtab
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 expandtab

" python
" vim-python
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 colorcolumn=79
      \ formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END

" vim-airline
let g:airline#extensions#virtualenv#enabled = 1

" Local vimrc
let g:localvimrc_whitelist = ['/home/neil/Desktop/18349/',
            \ '/home/neil/Desktop/Chain-MiBench',
            \ '/home/neil/Desktop/app-blinker-chain']

"*********************************************************************
"" Convenience variables
"*********************************************************************

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  let g:airline_left_sep          = '▶'
  let g:airline_left_alt_sep      = '»'
  let g:airline_right_sep         = '◀'
  let g:airline_right_alt_sep     = '«'
  let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
  let g:airline#extensions#readonly#symbol   = '⊘'
  let g:airline#extensions#linecolumn#prefix = '¶'
  let g:airline#extensions#paste#symbol      = 'ρ'
  let g:airline_symbols.linenr    = '␊'
  let g:airline_symbols.branch    = '⎇'
  let g:airline_symbols.paste     = 'ρ'
  let g:airline_symbols.paste     = 'Þ'
  let g:airline_symbols.paste     = '∥'
  let g:airline_symbols.whitespace = 'Ξ'
else
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif

" Disable arrow keys for hardmode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

autocmd BufRead,BufNewFile *.h,*.c set filetype=c
