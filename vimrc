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

Plug 'w0rp/ale'

Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'Yggdroot/indentLine' " Display indentation with vertical lines
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'junegunn/goyo.vim'

Plug 'mattn/calendar-vim'
Plug 'vimwiki/vimwiki'

" Color
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
let g:ctrlp_map = '<Leader>f'
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
" Ale {{{
let g:ale_close_preview_on_insert = 1 " Close preview window on insert mode
let g:ale_sign_error='✗'
let g:ale_sign_warning='⚠'
let g:ale_sign_style_error='✗'
let g:ale_sign_style_warning='⚠'
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_history_enabled=0
let g:ale_linters= { 'python': ['pylint']}
let g:ale_maximum_file_size=100000
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave = 0
" }}}
" vim-airline {{{
let g:airline_theme = 'onedark'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
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
" indentLine {{{
let g:indentLine_color_term = 252
let g:indentLine_setConceal=0  " Don't let indentLine override conceal settings
" }}}
" vimwiki {{{
" TODO highlighting folds (pending github issue)
" TODO Taskwarrior and vim-taskwarrior integration
" TODO Look into auto-export at a different frequency than on-save
"      Can just run VimwikiAll2HTML
" TODO Look into tags (Tagbar, Taglist)
" TODO Try lervag/wiki.vim -- probably will work better for markdown
"      Can use junegunn/vim-easy-align for tables, other stuff seems to
"      already be there
" customwiki2html from https://github.com/vimwiki/vimwiki/issues/642
let g:vimwiki_list = [{'path': '~/All-Sync/wiki/',
                    \ 'path_html': '~/All-Sync/wiki/html',
                    \ 'custom_wiki2html' : '~/.files/convert.py',
                    \ 'syntax': 'markdown',
                    \ 'ext': '.md'}]
" let g:vimwiki_global_ext=0 " Don't treat every .md file as Vimwiki
let g:vimwiki_conceallevel=2
let g:vimwiki_url_maxsave = 0 " Always show entire URL links (consider changing to 15)
let g:vimwiki_folding = 'expr:quick'
let g:vimwiki_hl_headers = 1 " Use different colors for different header levels
let g:vimwiki_hl_cb_checked = 2 " Grey-out done tasks and their notes
let g:vimwiki_listsyms = '✗○◐●✓'
"Vimwiki autocmd {{{
augroup vimrc-vimwiki
    autocmd!
    autocmd FileType vimwiki setlocal textwidth=80 autoindent
        \ spell formatoptions=nq wrap wm=2 colorcolumn=80
augroup END
"}}}
" autocmd FileType vimwiki highlight Folded gui=italic guifg=5 guibg=Grey20
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

set conceallevel=2   "Give placeholder for hidden text
set concealcursor=nc "Give placeholder for hidden text
set relativenumber   "Show relative number above and below
set number           "Precede line with number

" Make sure that NeoVim knows where to look
let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/local/bin/python3"
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
noremap <Leader>l :set invrelativenumber<CR> :set invnumber<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Goyo mode with Gitgutter
nnoremap <Leader>G :Goyo<CR>:GitGutterEnable<CR>

" Windows
nnoremap <Leader>w- :<C-u>split<CR>
nnoremap <Leader>w\| :<C-u>vsplit<CR>
nnoremap <Leader>wN :tabnew<CR>
nnoremap <Leader>wp :tabprevious<CR>
nnoremap <Leader>wn :tabnext<CR>
nnoremap <Leader>wr <C-W>r
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
    nnoremap <Leader>ss :terminal<CR>i
    nnoremap <Leader>s\| :<C-u>vsplit<CR>:term<CR>
    nnoremap <Leader>s- :<C-u>split<CR>:term<CR>
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-w> <C-\><C-n>:bdelete!<CR>
else
    nnoremap <Leader>sh :shell<CR>
endif
"}}}

" Buffers and Windows
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>d :bdelete<CR>

" Opens an edit command with path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

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
" Ale {{{
nnoremap <Leader>cc :ALEEnableBuffer<CR> :ALELint<CR>
nnoremap <Leader>cr :ALEDisableBuffer<CR>
nnoremap <Leader>ci :ALEInfo<CR>
"}}}

map <silent> <C-n> :NERDTreeToggle<CR>
"}}}
" vim:foldmethod=marker:foldlevel=0
