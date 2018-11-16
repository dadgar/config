set nocompatible
filetype off
let mapleader=","
set t_Co=256
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'
" My Bundles
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'bling/vim-airline'
Plugin 'simnalamburt/vim-mundo'
Plugin 'scrooloose/nerdcommenter'
Plugin 'godlygeek/tabular'
Plugin 'junegunn/vim-easy-align'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'justinmk/vim-sneak'
Plugin 'kien/ctrlp.vim'
Plugin 'dantler/vim-alternate'
Plugin 'vim-scripts/Figlet.vim'
Plugin 'rking/ag.vim'
Plugin 'mhinz/vim-signify'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
Plugin 'kshenoy/vim-signature'
Plugin 'fatih/vim-go'
Plugin 'leshill/vim-json'
Plugin 'moll/vim-bbye'
Plugin 'henrik/vim-indexed-search'
Plugin 'Shougo/deoplete.nvim'
Plugin 'zchee/deoplete-go', { 'do': 'make'}
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'shime/vim-livedown'
Plugin 'junegunn/goyo.vim'
Plugin 'fatih/vim-hclfmt'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'neomake/neomake'
Plugin 'gabesoft/vim-ags'
Plugin 'mdempsky/gocode', {'rtp': 'nvim/'}
Plugin 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'
Plugin 'ncm2/ncm2-go'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-syntax'  | Plugin 'Shougo/neco-syntax'
Plugin 'wellle/tmux-complete.vim'
Plugin 'ncm2/ncm2-ultisnips'
Plugin 'SirVer/ultisnips'

" Colors
Plugin 'ayu-theme/ayu-vim'
Plugin 'dadgar/vim-luna'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call vundle#end()            " required
filetype plugin indent on    " required

" gui colors if running iTerm
if $TERM_PROGRAM =~ "iTerm"
  set termguicolors
endif

colorscheme Tomorrow-Night-Eighties

" Disable arrows
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Line num and position
set relativenumber
set number
set ruler
set scrolloff=5 " Number of lines above or bellow the current line

" Highlighting
set hlsearch
set incsearch
set ignorecase

"Indents
set smartindent
set smarttab
set smartcase
set autoindent
set expandtab
set tabstop=4

" Undo File
set undofile
set undodir=~/.vimundo/

" Keep selection after tab adjust
vnoremap < <gv
vnoremap > >gv

" Enable file backup (atomic)
set noswapfile
set backupdir=~/.vimbackup
set backup
set writebackup

" Syntax
syntax on
filetype plugin indent on
set showmatch

" Wrapping
set textwidth=80
set fo+=t
set nowrap

" Buffer navigation
map <Leader>bn :bn<cr>
map <Leader>bp :bp<cr>
map <Leader>bd :Bdelete<cr>

" List navigation
map <Leader>ll :lfirst<cr>
map <Leader>ln :lnext<cr>
map <Leader>lp :lprevious<cr>

" MISC
set shortmess+=filmnrxoOtT " Abbreviate and avoid hit enter
set virtualedit=onemore    " Allow for cursor beyond last character
imap jj <Esc>
set wildmenu
set wildignore+=*.o,*.so,*.swp,*.zip,*.class,*.pyc
set autowriteall " Automatically writes when switching buffers
set updatetime=4000
set backspace=2
set ttyfast
set lazyredraw

" Use system clipboard
set clipboard=unnamed

" Default to 2 spaces per tab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Remove toolbar from gui
if has("gui_running")
    set guioptions-=T
endif

" More history
set history=10000
set undolevels=1000

" Ag
let g:ag_working_path_mode="r"

" CtrlP
set wildignore+=*/ui
let g:ctrlp_extensions = ['tag', 'buffertag', 'undo', 'changes']
map <C-p> :CtrlP<Enter>
map <C-b> :CtrlPBuffer<Enter>
map <C-s> :CtrlPTag<Enter>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]vendor$',
  \ }

" Airline
set laststatus=2
let g:airline_theme='luna'
let g:signify_mapping_toggle_highlight = '<leader>gh'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#neomake#enabled = 1

" Airline go test run status
function! GoTestRes()
    let lastStatus = go#statusline#Show()
    return lastStatus
endfunction

function! GoTestPassed()
    let lastStatus = go#statusline#Show()
    if lastStatus =~ "success" || lastStatus =~ "finished" || lastStatus =~ "pass"
        return 1
    endif

    return 0
endfunction

let g:go_statusline_duration = 15000
call airline#parts#define_function('gotestpassing', 'GoTestRes')
call airline#parts#define_condition('gotestpassing', 'GoTestPassed()')
call airline#parts#define_accent('gotestpassing', 'green')
call airline#parts#define_function('gotestrun', 'GoTestRes')
call airline#parts#define_condition('gotestrun', 'GoTestPassed() == 0')
call airline#parts#define_accent('gotestrun', 'purple')
let g:airline_section_c = airline#section#create_right(['gotestpassing', 'gotestrun'])

" Signify
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" vim-go
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_def_mapping_enabled = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
let g:go_snippet_engine = "neosnippet"
let g:go_metalinter_deadline = "30s"
let g:go_metalinter_command = 'gometalinter
\ --vendor
\ --exclude=".*\.generated\.go"
\ --exclude=".*bindata_assetfs\.go"
\ --exclude="ui"
\ --exclude="vendor"
\ --skip="ui/"
\ --skip="vendor/"
\ --sort="path"
\ --aggregate
\ --enable-gc
\ --enable=goimports
\ --enable=misspell
\ --enable=vet
\ --enable=deadcode
\ --enable=varcheck
\ --enable=ineffassign
\ --enable=structcheck
\ --enable=unconvert
\ --enable=gofmt
\ ./...'

" Easy-align
vnoremap <silent> <leader>a :EasyAlign<Enter>

" TagBar
nnoremap <silent> <leader>tt :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_type_go = {
	\ 'ctagstype' : 'go',
	\ 'kinds'     : [
		\ 'p:package',
		\ 'i:imports:1',
		\ 'c:constants',
		\ 'v:variables',
		\ 't:types',
		\ 'n:interfaces',
		\ 'w:fields',
		\ 'e:embedded',
		\ 'm:methods',
		\ 'r:constructor',
		\ 'f:functions'
	\ ],
	\ 'sro' : '.',
	\ 'kind2scope' : {
		\ 't' : 'ctype',
		\ 'n' : 'ntype'
	\ },
	\ 'scope2kind' : {
		\ 'ctype' : 't',
		\ 'ntype' : 'n'
	\ },
	\ 'ctagsbin'  : 'gotags',
	\ 'ctagsargs' : '-sort -silent'
\ }

" Index Search
let g:indexed_search_colors=0

" Neomake
function! SetTags(tags)
    exe 'GoBuildTags ' . a:tags
    let g:neomake_go_go_maker = {
    \ 'args': [
        \ 'test', '-c', '-tags', a:tags,
        \ '-o', neomake#utils#DevNull(),
    \ ],
    \ 'append_file': 0,
    \ 'cwd': '%:h',
    \ 'serialize': 1,
    \ 'serialize_abort_on_error': 1,
    \ 'errorformat':
        \ '%W%f:%l: warning: %m,' .
        \ '%E%f:%l:%c:%m,' .
        \ '%E%f:%l:%m,' .
        \ '%C%\s%\+%m,' .
        \ '%-G#%.%#'
    \ }
endfunction

call neomake#configure#automake('w')
let g:neomake_open_list = 2
let g:neomake_go_enabled_makers = ['go']

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeIgnore=['\.class', '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.o']
let NERDTreeQuitOnOpen=1

"Deocomplete
let g:deoplete#enable_at_startup = 0
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/darwin_amd64'
set completeopt+=noinsert
set completeopt+=noselect

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
set completeopt-=preview

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
		
 " c-j c-k for moving in snippet
inoremap <silent> <expr> <CR> pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>"
let g:UltiSnipsExpandTrigger		= "<Plug>(ultisnips_expand)"
let g:UltiSnipsJumpForwardTrigger	= "<c-j>"
let g:UltiSnipsJumpBackwardTrigger	= "<c-k>"
let g:UltiSnipsRemoveSelectModeMappings = 0

" GO Syntax
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on

" HCL Syntax
let g:hcl_fmt_autosave = 0

" neosnippet
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
