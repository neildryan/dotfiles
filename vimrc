set encoding=utf-8
scriptencoding utf-8
" TODO Play around with soft-wrapping; use columns and maybe vim-pencil again

" Quick Fixes
" - Keybinding to insert text to drop into python debugger in .py files either side
" TODO How much can be done with tex by just using built-ins? See
" g:tex_fold_enabled
" TODO Tagbar configuration
" TODO https://github.com/sbdchd/neoformat
" TODO http://proselint.com/, probably replace vim-wordly, other writing linters

" TODO Is there a way to put spelling suggestions in a floating window in Nvim?
"   Yes, but I'd probably have to do it myself
" TODO https://github.com/rafaqz/citation.vim

" Vim-plug core installation {{{
let vimplug_exists= has('nvim') ? expand('~/.config/nvim/autoload/plug.vim') :
                               \ expand('~/.vim/autoload/plug.vim')
if !filereadable(vimplug_exists)
    echo 'Installing Vim-Plug...'
    echo ''
    silent !\curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
        \  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    let g:not_finish_vimplug = 'yes'

    autocmd VimEnter * PlugInstall
endif
if has('nvim')
    call plug#begin(expand('~/.config/nvim/plugged'))
else
    call plug#begin(expand('~/.vim/plugged'))
endif
"}}}
" Functions {{{
" Set number display only when not in terminal (currently never sets) {{{
function! s:setNumberDisplay()
    if &buftype ==# 'terminal'
        setlocal nonumber
        setlocal norelativenumber
    endif
    setlocal nonumber
    setlocal norelativenumber
endfunction
"}}}
"Strip whitespace in file with :StripWhitespace {{{
function! s:StripWhitespace(line1, line2)
    " Save the current search and cursor position
    let _s=@/
    let l = line('.')
    let c = col('.')

    let ws_chars='\u0020\u00a0\u1680\u180e\u2000-\u200b\u202f\u205f\u3000\ufeff'
    let eol_ws_pattern = '[\u0009' . ws_chars . ']\+$'
    " Skip empty lines
    let ws_pattern= '[^\u0009' . ws_chars . ']\@1<=' . eol_ws_pattern

    " Strip whitespace
    silent execute ':' . a:line1 . ',' . a:line2 . 's/' . ws_pattern . '//e'

    " Always strip empty lines at EOF
    if a:line2 >= line('$')
        silent execute '%s/\(\n\)\+\%$//e'
    endif

    " Restore the saved search and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
command! -bang -range=% StripWhitespace call s:StripWhitespace(<line1>, <line2>)
"}}}
" Toggle conceallevel {{{
function! ToggleConceal()
    if &conceallevel > 0
        setlocal conceallevel=0
    else
        setlocal conceallevel=2
    endif
endfunction
"}}}
"{{{ Goyo Enter/Leave
function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    set scrolloff=999
    Limelight .7
    set wrap
    set linebreak
    map j gj
    map k gk
endfunction

function! s:goyo_leave()
    set showmode
    set showcmd
    set scrolloff=3
    Limelight!
    unmap j
    unmap k
    " ...
endfunction

"}}}
"}}}
" Plugins {{{
" Installation {{{
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-obsession'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'simnalamburt/vim-mundo'

Plug 'xolox/vim-misc'
Plug 'xolox/vim-easytags'
Plug 'preservim/tagbar'

let g:polyglot_disabled = ['latex'] " Needs to be set before loading plugin
Plug 'sheerun/vim-polyglot'

" Stuff for wiki
Plug 'junegunn/vim-easy-align'
Plug 'plasticboy/vim-markdown'
Plug 'lervag/wiki.vim'

Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'
Plug 'lervag/vimtex'

" Color
Plug 'wadackel/vim-dogrun'
Plug 'reedes/vim-colors-pencil'

" Potentially could remove, I only use :BD and this adds a lot of extra stuff
Plug 'qpkorr/vim-bufkill' " Remove buffers without changing window layout
" Potentially could remove; again, I only use the teeniest bit
Plug 'Yggdroot/indentLine' " Display indentation with vertical lines

call plug#end()
"}}}
" Ale {{{
let g:ale_close_preview_on_insert = 1 " Close preview window on insert mode
let g:ale_sign_error='✗'
let g:ale_sign_warning='⚠'
let g:ale_sign_style_error='✗'
let g:ale_sign_style_warning='⚠'
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_history_enabled=0
let g:ale_linters= {
    \ 'python': ['pylint'],
    \ 'vim': ['vint'],
    \ 'markdown':['proselint', 'languagetool', 'markdownlint']}
let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
    \ 'markdown': ['remark-lint']
    \}
let g:ale_python_pylint_options = '--load-plugins pylint_django'
let g:ale_maximum_file_size=100000
let g:ale_lint_on_text_changed=0
let g:ale_lint_on_insert_leave=1
" }}}
"Vimtex/Lexical {{{
let g:vimtex_fold_enabled = 1
let g:vimtex_imaps_enabled = 0
let g:vimtex_mappings_enabled = 0

let g:lexical#thesaurus = ['~/.files/thesaurus.txt']
let g:lexical#spellfile = ['~/.files/en.utf-8.add']
"}}}
" Airline {{{
let g:airline_theme='dogrun'

let g:airline_skip_empty_sections = 1
let g:airline_detect_spell = 0  " Ignore spell and spelling
let g:airline_detect_spelllang = 0

" TODO Maybe add fugutiveline, vimtex, searchcount
" TODO change session indicator to powerline symbol
" TODO Personalize sections?
let g:airline_extensions = [
            \ 'branch', 'fzf', 'obsession',
            \ 'tabline', 'term', 'whitespace', 'wordcount'
            \ ]
let g:airline#extensions#obsession#indicator_text = '$'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_type = 1
" let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1 "
let g:airline#extensions#tabline#show_tabs = 0 " Don't need to see them

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_left_sep = ''
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_left_alt_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_symbols.dirty='⚡'

let g:airline_section_c = '%t'
"}}}
" Vim Markdown {{{
let g:vim_markdown_auto_insert_bullets = 0
" Number of space to indent new list items (affects gq)
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_folding_style_pythonic = 1 " Foldtext is header
let g:vim_markdown_no_default_key_mappings = 1
" }}}
" Wiki.vim {{{
let g:wiki_root = '/Users/neilryan/wiki/'
let g:wiki_mappings_use_defaults = 'none' " Define my own, avoid conflicts
let g:wiki_filetypes = ['markdown', 'md'] " Associated .md files with Wiki.vim
let g:wiki_link_target_type = 'md' " Use markdown style links
let g:wiki_link_extension = '.md' "
let g:wiki_link_toggle_on_open = 0
let g:wiki_zotero_root='~/Documents/Zotero' " Currently does nothing
" Keep <Tab> and <S-Tab> mappings
let g:wiki_mappings_global = {
        \ '<plug>(wiki-link-next)' : '<C-n>',
        \ '<plug>(wiki-link-prev)' : '<C-p>'
        \}
" WikiPageExport {{{
function! s:WikiPageExport(view)
let curr_file = expand('%:p')
if (stridx(curr_file, g:wiki_root)) < 0  "Only run in wiki directory
    " echoerr 'WikiPageExport can only run on files in ' . g:wiki_root
    " echoerr 'Current file ' . curr_file
    return
endif
let first_line = getbufline(bufname(), 1)[0]
let title = substitute(first_line, '#', '', 'g')

" This is all run on export so that `title` matches
let s:meta_title = '-M title="' . title . '"'
let s:meta_date = '-M date='.strftime('%Y-%m-%d')
let s:template = '--template template.html'
let g:wiki_export = {
    \ 'args' : s:template . ' ' . s:meta_date . ' ' . s:meta_title,
    \ 'from_format' : 'markdown_github',
    \ 'ext' : 'html',
    \ 'output': 'html',
    \ 'view': a:view,
    \ 'link_ext_replace': 1
    \}
execute ':WikiExport'
endfunction
command! -bang -range=% WikiPageExport call s:WikiPageExport(1)
"}}}
" }}}
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.4 }}
let g:goyo_width = 70

let g:BufKillCreateMappings=0

let g:indentLine_color_term = 252
let g:indentLine_setConceal=0  " Don't let indentLine override conceal settings
let g:indentLine_bufNameExclude = ['term:.*']
let g:highlightedyank_highlight_duration = 300

let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 1
let g:easytags_async = 1
"}}}
" Basic settings {{{
" Required {{{
filetype plugin indent on

set fileencoding=utf-8
set fileencodings=utf-8
set spellfile="~/.files/en.utf-8.add"
" set spellsuggest+=10  "z= should give 10 results and no more
set bomb
set binary
if !has('nvim')
    set ttyfast
endif
set fileformats=unix,dos,mac
set showcmd       " Show partial command in last line of screen
set ruler
set backspace=indent,eol,start " Fix backspace indent
set hidden "Enable hidden buffers
set noerrorbells visualbell t_vb= "Disable visualbell

"" Use modeline overrides
set modeline
set modelines=1

"}}}
"Abbreviations {{{
cnoreabbrev W!    w!
cnoreabbrev Q!    q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq    wq
cnoreabbrev Wa    wa
cnoreabbrev wQ    wq
cnoreabbrev WQ    wq
cnoreabbrev W     w
cnoreabbrev Q     q
cnoreabbrev Qall  qall
"}}}
" Tabs {{{
set tabstop=4      "number of visual spaces per TAB
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

set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite

" The Silver Searcher {{{
if executable('ag')
    " Use Ag instead of grep
    set grepprg=ag\ --nogroup\ --nocolor

    if !exists(':Ag')
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
" iTerm Cursor Fix {{{
if has('osx')
    let &t_SI = '\<Esc>]50;CursorShape=1\x7'
    let &t_SR = '\<Esc>]50;CursorShape=2\x7'
    let &t_EI = '\<Esc>]50;CursorShape=0\x7'
endif
"}}}
" Leader & Misc {{{
let mapleader=' '
let localleader=' '

" Directories for swp files
set nobackup        " No backup file create when overwriting

set shortmess=atI   "All abbreviations, truncate file message, no intro
set ttimeoutlen=50  "Time to wait for keycode/sequence to complete
set scrolloff=3     "Minimum number of lines to keep above & below cursor
set mouse=a         "Fix mouse scroll
set autoread        "Autoread if modified outside of vim
set lazyredraw      "Don't redraw when executing macros/registers

set conceallevel=2   "Give placeholder for hidden text
set concealcursor=nc "Give placeholder for hidden text
set colorcolumn=80   "Color the 80th column

" Make sure that NeoVim knows where to look
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

let g:tex_fold_enabled=1
let g:tex_flavor='latex'
" Just save it all
let sessionoptions='buffers,folds,resize,terminal,winpos,winsize,curdir'
"}}}
" }}}
" Colors {{{
colo dogrun
" Stuff for vim-colors-pencil, if I go back to it
let g:pencil_gutter_color = 1
let g:pencil_spell_undercurl = 1
let g:pencil_terminal_italics = 1
let g:pencil_neutral_headings = 1
" Terminal Color Fixes {{{
set t_Co=256   " 256 color
if !has('nvim')
    if $COLORTERM ==# 'gnome-terminal'
        set term=gnome-256color
    else
        if $TERM ==# 'xterm'
            set term=xterm-256color
        endif
    endif
    if &term =~# '256color'
        set t_ut=
    endif
endif
if (has('nvim'))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"}}}
" TermGuiColors {{{
if !exists('g:not_finish_vimplug')
    if (has('termguicolors'))
        set termguicolors
    endif
    syntax on
endif
"}}}
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
"Markdown (and wiki) files {{{
" 60 characters per line is best for readability
" See vim-markdown github issue #390 for explanation
augroup writing-markdown
    autocmd!

    autocmd FileType markdown setlocal spell autoindent nowrap
    autocmd FileType markdown setlocal textwidth=60 wrapmargin=2
    autocmd FileType markdown setlocal comments=fb:>,fb:*,fb:+,fb:-
    autocmd FileType markdown setlocal formatoptions=tcqjnb
    autocmd FileType markdown setlocal scrolloff=999
    autocmd FileType markdown call lexical#init()
    autocmd BufWritePost *.md silent call s:WikiPageExport(0)

augroup end
"}}}
" {{{ Goyo Enter/Leave
augroup goyo-transition
    autocmd!

    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup end

" }}}
" Tex files {{{
augroup writing-tex
    autocmd!
    autocmd FileType tex call lexical#init()
    autocmd FileType tex setlocal formatoptions=tcnqrjaw tw=80
    autocmd FileType tex setlocal spell wrap
    autocmd FileType tex setlocal nonumber norelativenumber
    autocmd FileType tex setlocal linebreak showbreak=>
    autocmd FileType tex setlocal scrolloff=999 " Center text in page
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
    autocmd BufRead,BufNewFile *.h,*.c setlocal filetype=c
                \ | setlocal number relativenumber
augroup END
"}}}
" Highlighting TODO and CITE{{{
augroup vimrc_todo
    autocmd!
    autocmd Syntax * syn match MyTodo /\v<(CITE|TODO)/
                \ containedin=ALL " Can change to .*Comment for just comments
augroup END
hi def link MyTodo Todo
"}}}
" python files {{{
augroup vimrc-python
  autocmd!
  autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
        \ colorcolumn=79 formatoptions+=croq softtabstop=4
        \ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
        \ | setlocal number relativenumber
augroup END
"}}}
" General Code Files (just vim now) {{{
augroup coding
    autocmd!
    autocmd Filetype vim setlocal formatoptions=njcnroql textwidth=80
    autocmd Filetype vim setlocal colorcolumn=79 shiftwidth=4 tabstop=4
    autocmd Filetype vim setlocal expandtab softtabstop=4
augroup END
" }}}
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
                \ |call rpcrequest(g:r, 'nvim_command', 'edit '.g:f)
                \ |qa
                \ |endif

    " enter insert mode whenever we're in a terminal
    autocmd TermOpen,BufWinEnter,BufEnter term://* startinsert

    " Auto-close terminal
    autocmd TermClose term://* call nvim_input('<CR>')
augroup END
"}}}
"}}}
" Key Mappings {{{
" Wiki stuff {{{
" Generate html with vim-pandoc
nmap <Leader>kk <plug>(wiki-index)
nmap <Leader>kb <plug>(wiki-graph-find-backlinks)
nmap <Leader>kg <plug>(wiki-graph-in)
nmap <Leader>kG <plug>(wiki-graph-out)
nmap <Leader>kt <plug>(wiki-tag-list)
nmap <Leader>kr <plug>(wiki-page-remame)
nmap <Leader>kd <plug>(wiki-page-delete)
nmap <Leader>ke :WikiPageExport<CR>
nmap <Leader>kx <plug>(wiki-list-toggle)
nmap <Leader>kn :lnext<CR>
nmap <Leader>kp :lprev<CR>

nmap <cr> f[<plug>(wiki-link-open)
nmap <bs> <plug>(wiki-link-return)

nmap gx <Plug>Markdown_OpenUrlUnderCursor
nmap ]] <Plug>Markdown_MoveToNextHeader
nmap [[ <Plug>Markdown_MoveToPreviousHeader
nmap ]c <Plug>Markdown_MoveToCurHeader
nmap [c <Plug>Markdown_MoveToCurHeader
" }}}
" Windows and Splits {{{
nnoremap <Leader>wj :<C-u>split<CR>
nnoremap <Leader>wl :<C-u>vsplit<CR>
nnoremap <Leader>wN :tabnew<CR>
nnoremap <Leader>wp :tabprevious<CR>
nnoremap <Leader>wn :tabnext<CR>
nnoremap <Leader>wr <C-W>r
nnoremap <Leader>w= <C-W>=
nnoremap <Leader>D :q<CR>
set splitbelow
set splitright
"}}}
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
noremap <Leader>gp :Gpush<CR>
noremap <Leader>gl :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
"}}}
" Shell, shell splits {{{
if has('nvim')
    nnoremap <Leader>tt :terminal<CR>
    nnoremap <Leader>tl :<C-u>vsplit<CR>:term<CR>
    nnoremap <Leader>tj :<C-u>split<CR>:term<CR>
    nnoremap <Leader>tN :tabnew<CR>:terminal<CR>
    tnoremap <Esc> <C-\><C-n>
else
    nnoremap <Leader>sh :shell<CR>
endif
"}}}
" Buffers {{{
nnoremap <Leader>d :BD<CR>
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <Leader>p <Plug>AirlineSelectPrevTab
nmap <Leader>n <Plug>AirlineSelectNextTab
"}}}
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
nnoremap <Leader>ae :ALEEnableBuffer<CR> :ALELint<CR>
nnoremap <Leader>aD :ALEDisableBuffer<CR>
nnoremap <Leader>ai :ALEInfo<CR>
nnoremap <Leader>ad :ALEDetail<CR>
nnoremap <Leader>an :ALENext<CR>
nnoremap <Leader>ap :ALEPrevious<CR>
nnoremap <Leader>af :ALEFix<CR>
"}}}
" Misc/dumping ground {{{
" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in and open folds
nmap n kzzzv
nmap N Kzzzv

nnoremap <Leader>u :MundoToggle<CR>
nnoremap <Leader>c :call ToggleConceal()<CR>
nnoremap <Leader>o :TagbarToggle<CR>
"Focus the current fold by closing all others
nnoremap <S-Tab> zMzvzt
"Toggle current fold
nnoremap <Tab> za

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nnoremap <Leader>v :e ~/.vimrc<CR>
nnoremap <Leader>V :so $MYVIMRC<CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <silent> <leader>f :FZF<cr>
vnoremap <Leader>y :join<CR>yyu

"" Goyo mode
nnoremap <Leader>G :Goyo<CR>

" Strip whitespace
nnoremap <Leader>s :StripWhitespace<CR>

" Format tables (`vim-markdown`)
vnoremap <Leader>T :EasyAlign * \|<CR>

" }}}
"}}}
"}}}
" vim:foldmethod=marker:foldlevel=0
