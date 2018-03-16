" TODO craigemery/vim-autotag - auto ctag generation
" TODO Tagbar,taglist
" Vim-plug core installation {{{
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
    call plug#begin(expand('~/.vim/plugged'))
endif
"}}}
" Plugins {{{
" Installation {{{
if has('nvim')
    Plug 'neomake/neomake'
else
    Plug 'scrooloose/syntastic'
endif


Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'xolox/vim-misc' "Pre-req for vim-session
Plug 'xolox/vim-session'

Plug 'tpope/vim-capslock'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'embear/vim-localvimrc'

Plug 'Yggdroot/indentLine'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'junegunn/goyo.vim'
"" Color
Plug 'joshdick/onedark.vim'

call plug#end()
"}}}
" NERDTree {{{
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
"}}}
" Ctrlp.vim {{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlPCurWD'
let g:ctrlp_arg_map = 1
let g:ctrlp_follow_symlinks = 1 " Follow but avoid recursive
let g:ctrlp_brief_prompt = 1 "<bs> on empty prompt exits
if executable('ag')
    " Use ag in CtrlP for listing files; fast and respects .gitignore
    let g:ctrlp_user_command = 'ag -Q -l --nocolor --hidden -g "" %s'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
else
    let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
    let g:ctrlp_use_caching = 1
endif
"}}}
" Syntastic {{{
if !has('nvim')
    let g:syntastic_always_populate_loc_list=1
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_style_error_symbol = '✗'
    let g:syntastic_style_warning_symbol = '⚠'
    let g:syntastic_auto_loc_list=1
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_mode_map = { 'mode': 'passive',
                \'active_filetypes': ["python"],
                \'passive_filetypes': [] }
endif
"}}}
" Neomake - Auto-run on read/write disabled {{{
if has('nvim')
    "autocmd! BufWritePost,BufEnter * Neomake " Run on read/write
    let g:neomake_open_list = 2 " Auto-open error window
    let g:neomake_error_sign = {
                \ 'text': '✗',
                \ 'texthl': 'WarningMsg'}
    let g:neomake_warning_sign = {
                \ 'text': '⚠',
                \ 'texthl': 'ErrorMsg'}
endif
"}}}
" vim-airline {{{
let g:airline_theme = 'onedark'
if has('nvim')
    let g:airline#extensions#neomake#enabled = 1
else
    let g:airline#extensions#syntastic#enabled = 1
endif

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#capslock#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

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
"}}}
" vim-localvimrc {{{
let g:localvimrc_name = [".lvimrc"]
let g:localvimrc_event = ["BufWinEnter", "BufEnter"]
let g:localvimrc_sandbox = 0
let g:localvimrc_whitelist = ['/home/neil/Documents/docker-coati/coati/',
            \ '/home/neil/Documents/349-s17']
"}}}
" indentLine {{{
let g:indentLine_color_term = 252
" }}}
"}}}
" Basic settings {{{
" Required {{{
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary
if !has('nvim')
    set ttyfast
endif
set fileformats=unix,dos,mac
set showcmd       " Show partial command in last line of screen
set ruler

"" Fix backspace indent
set backspace=indent,eol,start

"" Enable hidden buffers
set hidden
"
"" Disable visualbell
set noerrorbells visualbell t_vb=

"" Use modeline overrides
set modeline
set modelines=10
"}}}
"Abbreviations {{{
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
"}}}
" Tabs {{{
set tabstop=8      "number of visual spaces per TAB
set softtabstop=4  "number of spaces in tab when editing
set shiftwidth=4   "number of spaces for << and >>
set expandtab      "tabs are spaces
set shiftround     "Round indentation to nearest multiple of shiftwidth
"}}}
" Searching {{{
set hlsearch   "highlight search matches
set incsearch  "Search as characters are entered
set ignorecase "Ignore case in searching
set smartcase  "Don't ignore case if query has uppercase letters
set showmatch  "highlight matching [{()}]

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in and open folds
nnoremap n nzzzv
nnoremap N Nzzzv
"}}}
" Status bar {{{
set laststatus=2

set title
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
"}}}
" Copy/Paste/Cut with X11+ {{{
if has('unnamedplus')
  set clipboard=unnamed,unnamedplus
endif
"}}}
" Session management {{{
if has('nvim')
    let g:session_directory = "~/.config/nvim/session"
else
    let g:session_directory = "~/.vim/session"
endif

let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1
"}}}
" iTerm Cursor Fix {{{
if has("osx")
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"}}}
" Leader & Misc {{{
let mapleader=' '

" Directories for swp files
set nobackup        " No backup file create when overwriting
set noswapfile      " No swap files

set shortmess=atI   "All abbreviations, truncate file message, no intro
set ttimeoutlen=50  "Time to wait for keycode/sequence to complete
set scrolloff=3     "Minimum number of lines to keep above & below cursor
set mouse=a         "Fix mouse scroll
set autoread        "Autoread if modified outside of vim
set lazyredraw      "Don't redraw when executing macros/registers
"}}}
" }}}
" Colors {{{
" Terminal Color Fixes {{{
set t_Co=256   " 256 color
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
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"}}}
" Colorschemes {{{
if !exists('g:not_finish_vimplug')
    if (has("termguicolors"))
        set termguicolors
    endif
    syntax on
    colorscheme onedark
endif
"}}}
"}}}
" Functions {{{
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif
"}}}
" Autocmd Rules {{{
" Do syntax highlight syncing from start unless 200 lines {{{
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END
"}}}
" Remember cursor position {{{
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END
"}}}
" Auto-wrap text for .txt, .tex files {{{
augroup vimrc-wrapping
  autocmd!
  autocmd BufRead,BufNewFile *.txt,*.tex call s:setupWrapping()
  autocmd BufRead,BufNewFile *.txt,*.tex setlocal spell colorcolumn=80
augroup END
"}}}
" make/cmake files {{{
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END
"}}}
" .c, .h files {{{
autocmd BufRead,BufNewFile *.h,*.c set filetype=c colorcolumn=80
"}}}
" python files {{{
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
      \ colorcolumn=79 formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
"}}}
"Neovim - start insert on entering terminal buffer {{{
if has('nvim')
    autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
    autocmd BufLeave term://* stopinsert
endif
"}}}
"}}}
" Key Mappings {{{
let g:gitgutter_map_keys = 0 " Avoid <Leader>h conflicts

" Use M instead of ` for marks (the former is tmux prefix)
nnoremap M `
nnoremap ` M
onoremap M `
onoremap ` M

" Line numbers - default off
noremap <Leader>n :set invrelativenumber<CR> :set invnumber<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

" Split
nnoremap <Leader>- :<C-u>split<CR>
nnoremap <Leader>\| :<C-u>vsplit<CR>
set splitbelow
set splitright

" Switching windows {{{
if has('nvim')
    inoremap <C-j> <Esc><C-w>j
    inoremap <C-k> <Esc><C-w>k
    inoremap <C-l> <Esc><C-w>l
    inoremap <C-h> <Esc><C-w>h
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l
    noremap <C-h> <C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
    tnoremap <C-h> <C-\><C-n><C-w>h
else
    noremap <C-j> <C-w>j
    noremap <C-k> <C-w>k
    noremap <C-l> <C-w>l
    noremap <C-h> <C-w>h
endif
"}}}
" Git - fugitive {{{
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gp :Gpush<CR>
noremap <Leader>gl :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
"}}}
" Shell, shell splits {{{
if has('nvim')
    nnoremap <Leader>sh :terminal<CR>
    nnoremap <Leader>tv :<C-u>vsplit<CR>:term<CR>
    nnoremap <Leader>th :<C-u>split<CR>:term<CR>
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-d> <C-\><C-n>:bd!<CR>
    tnoremap <C-w> <C-\><C-n>:bdelete!<CR>
else
    nnoremap <Leader>sh :shell<CR>
endif
"}}}

" Buffers and Windows
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <C-w> :bdelete<CR>
nnoremap <C-d> :q<CR>

" Opens an edit command with path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Easy making
nnoremap <Leader>m :w<CR> :! make<CR>

" Disable arrow keys for hardmode, resize instead {{{
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

noremap <Up> :resize -1<CR>
noremap <Down> :resize +1<CR>
noremap <Left> :vertical resize -1<CR>
noremap <Right> :vertical resize +1<CR>
"}}}
" Neomake/Syntastic {{{
if has('nvim')
    noremap <Leader>c :Neomake!<CR>
    noremap <Leader>r :NeomakeCancelJobs<CR>
    noremap <Leader>i :NeomakeInfo<CR>
else
    nnoremap <Leader>c :SyntasticCheck<CR>
    nnoremap <Leader>r :SyntasticReset<CR>
    nnoremap <Leader>i :SyntasticInfo<CR>
endif
"}}}
" Sessions {{{
nnoremap <Leader>ss :SaveSession<CR>
nnoremap <Leader>sd :DeleteSession<CR>
nnoremap <Leader>so :OpenSession<CR>
nnoremap <Leader>sc :CloseSession<CR>
" }}}

noremap <F2> :NERDTreeToggle<CR>
"}}}
" The Silver Searcher {{{
if executable('ag')
    " Use Ag instead of grep
    set grepprg=ag\ --nogroup\ --nocolor

    if !exists(":Ag")
        command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
        nnoremap \ :Ag<SPACE>
  endif
endif
"}}}
let g:tex_conceal = " "
" vim:foldmethod=marker:foldlevel=0
