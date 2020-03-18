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
Plug 'qpkorr/vim-bufkill' " Remove buffers without changing window layout

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

Plug 'Yggdroot/indentLine' " Display indentation with vertical lines
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-obsession'
Plug 'junegunn/goyo.vim'

Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'lervag/vimtex'

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
" LeaderF {{{
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:Lf_WildIgore='\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:Lf_UseCache = 0
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
"Vimtex/Lexical {{{
let g:polyglot_disabled = ['latex']
let g:vimtex_fold_enabled = 1

let g:lexical#thesaurus = ['~/.files/thesaurus.txt']
let g:lexical#spellfile = ['~/.files/en.utf-8.add']
let g:lexical#thesaurus_key = '<leader>t'

"}}}
" vim-airline {{{
let g:airline_theme = 'onedark'

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1  " Top bar for tabs
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_skip_empty_sections = 1
let g:airline_detect_spell = 0  " Ignore spell and spelling
let g:airline_detect_spelllang = 0

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ' '

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:airline_section_c = '%t'
"}}}
" indentLine {{{
let g:indentLine_color_term = 252
let g:indentLine_setConceal=0  " Don't let indentLine override conceal settings
let g:indentLine_bufNameExclude = ["term:.*"]
" }}}
"}}}
" Basic settings {{{
" Required {{{
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set spellfile="~/.files/en.utf-8.add"
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
let localleader=' '

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
set colorcolumn=80   "Color the 80th column

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
if !exists('*s:setNumberDisplay')
    function! s:setNumberDisplay()
        if &buftype == 'terminal'
            setlocal nonumber
            setlocal norelativenumber
        else
            set number
            set relativenumber
        endif
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
" Prose writing files {{{
augroup writing
  autocmd!
  autocmd Filetype tex,markdown,text
              \ | call lexical#init()
              \ | setlocal formatoptions=tcnqrj
              \ | setlocal wm=2
              \ | setlocal textwidth=80
              \ | setlocal spell
              \ | setlocal wrap
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
augroup vimrc-c
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c
augroup END
"}}}
" python files {{{
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
      \ colorcolumn=79 formatoptions+=croq softtabstop=4
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
augroup END
"}}}
"Vimwiki autocmd {{{
augroup vimrc-vimwiki
    autocmd!
    autocmd FileType vimwiki setlocal textwidth=80 autoindent
        \ spell formatoptions=tnqrj wrap wm=2
        \ tabstop=2 shiftwidth=2 softtabstop=2 foldlevel=1
augroup END
" autocmd FileType vimwiki highlight Folded gui=italic guifg=5 guibg=Grey20
"}}}
"Startup -- Neovim terminal fixes {{{
"From hneutr/dotfiles autocommands.vim
augroup startup
    autocmd!

    " turn numbers on for normal buffers; turn them off for terminal buffers
    autocmd TermOpen,BufWinEnter * call s:setNumberDisplay()

    " when in a neovim terminal, add a buffer to the existing vim session
    " instead of nesting (credit justinmk)
    autocmd VimEnter * if !empty($NVIM_LISTEN_ADDRESS) && $NVIM_LISTEN_ADDRESS !=# v:servername
                \ |let g:r=jobstart(['nc', '-U', $NVIM_LISTEN_ADDRESS],{'rpc':v:true})
                \ |let g:f=fnameescape(expand('%:p'))
                \ |noau bwipe
                \ |call rpcrequest(g:r, "nvim_command", "edit ".g:f)
                \ |call rpcrequest(g:r, "nvim_command", "call lib#SetNumberDisplay()")
                \ |qa
                \ |endif

    " enter insert mode whenever we're in a terminal
    " autocmd TermOpen,BufWinEnter,BufEnter term://* startinsert

    " Auto-close terminal
    autocmd TermClose term://* call nvim_input('<CR>')
augroup END
"}}}
"}}}
" Key Mappings {{{
let g:gitgutter_map_keys = 0 " Avoid <Leader>h conflicts

" Use M instead of ` for marks (the former is tmux prefix)
nnoremap M `
nnoremap ` M
onoremap M `
onoremap ` M

map <silent> <C-n> :NERDTreeToggle<CR>
"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Goyo mode with Gitgutter
nnoremap <Leader>G :Goyo<CR>:GitGutterEnable<CR>

" Windows and Splits {{{
nnoremap <Leader>w- :<C-u>split<CR>
nnoremap <Leader>w\| :<C-u>vsplit<CR>
nnoremap <Leader>wN :tabnew<CR>
nnoremap <Leader>ws :tabnew<CR>:terminal<CR>i
nnoremap <Leader>wp :tabprevious<CR>
nnoremap <Leader>wn :tabnext<CR>
nnoremap <Leader>wr <C-W>r
set splitbelow
set splitright
"}}}
" Vimwiki new bindings {{{
map <Leader>kk <Plug>VimwikiIndex
map <Leader>ki <Plug>VimiwkiDiaryIndex
map <Leader>ks <Plug>VimwikiUISelect
map <Leader>kt <Plug>VimwikiTabIndex
" }}}
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
    nnoremap <Leader>s\| :<C-u>vsplit<CR>:term<CR>i
    nnoremap <Leader>s- :<C-u>split<CR>:term<CR>i
    nnoremap <Leader>sN :tabnew<CR>:terminal<CR>i
    tnoremap <Esc> <C-\><C-n>
else
    nnoremap <Leader>sh :shell<CR>
endif
"}}}
" Buffers {{{
nnoremap <Leader>n :bnext<CR>
nnoremap <Leader>p :bprevious<CR>
nnoremap <Leader>d :BD<CR>
"}}}

" Opens an edit command with path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" Disable arrow keys for hardmode, resize instead {{{
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

noremap <Up> :resize -2<CR>
noremap <Down> :resize +2<CR>
noremap <Left> :vertical resize -2<CR>
noremap <Right> :vertical resize +2<CR>
"}}}
" Ale {{{
nnoremap <Leader>cc :ALEEnableBuffer<CR> :ALELint<CR>
nnoremap <Leader>cr :ALEDisableBuffer<CR>
nnoremap <Leader>ci :ALEInfo<CR>
"}}}
"}}}
" vim:foldmethod=marker:foldlevel=0
