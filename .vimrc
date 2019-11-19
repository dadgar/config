set nocompatible
filetype off
let mapleader=","
set t_Co=256

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'
Plug 'simnalamburt/vim-mundo'
Plug 'scrooloose/nerdcommenter'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'Lokaltog/vim-easymotion'
Plug 'justinmk/vim-sneak'
Plug 'kien/ctrlp.vim'
Plug 'dantler/vim-alternate'
Plug 'vim-scripts/Figlet.vim'
Plug 'rking/ag.vim'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'kshenoy/vim-signature'
Plug 'fatih/vim-go'
Plug 'leshill/vim-json'
Plug 'moll/vim-bbye'
Plug 'henrik/vim-indexed-search'
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'shime/vim-livedown'
Plug 'junegunn/goyo.vim'
Plug 'fatih/vim-hclfmt'
Plug 'gabesoft/vim-ags'
"Plugin 'neomake/neomake'
"Plugin 'mdempsky/gocode', {'rtp': 'nvim/'}

"Plug 'autozimu/LanguageClient-neovim', {
    "\ 'branch': 'next',
    "\ 'do': 'bash install.sh',
    "\ }
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-go'
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-syntax'  | Plug 'Shougo/neco-syntax'

" Autocomplete
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Colors
Plug 'ayu-theme/ayu-vim'
Plug 'dadgar/vim-luna'
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

call plug#end()

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

" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

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
" Using CoC
let g:go_code_completion_enabled = 0
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_def_mode = 'gopls'
let g:go_info_mode = 'gopls'
let g:go_def_mapping_enabled = 1
let g:go_fmt_command = "goimports"
let g:go_list_type = "quickfix"
" let g:go_snippet_engine = "neosnippet"
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

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeIgnore=['\.class', '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.o']
let NERDTreeQuitOnOpen=1

" GO Syntax
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on

" HCL Syntax
let g:hcl_fmt_autosave = 0

" Neomake
"call neomake#configure#automake('w')
"let g:neomake_open_list = 2
"let g:neomake_go_enabled_makers = ['go']

"Deocomplete
"let g:deoplete#enable_at_startup = 0
"let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
"let g:deoplete#sources#go#use_cache = 1
"let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/darwin_amd64'

"set completeopt+=noinsert
"set completeopt+=noselect

"" <TAB>: completion.
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

""Disable the neosnippet preview candidate window
""When enabled, there can be too much visual noise
""especially when splits are used.
"set completeopt-=preview

 ""enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()
"au TextChangedI * call ncm2#auto_trigger()
"set completeopt=noinsert,menuone,noselect

 ""LSP
 ""Required for operations modifying multiple buffers like rename.
"set hidden
"let g:LanguageClient_serverCommands = {
    "\ 'go': ['go-langserver'],
    "\ }
"" a json file with settings for go-langserver:
"" {
"" 	"initializationOptions": {
"" 		"gocodeCompletionEnabled": true,
"" 		"funcSnippetEnabled": true
"" 	}
"" }
"let g:LanguageClient_settingsPath = '~/.vim/settings.json'
"nnoremap <silent> <leader>c :call LanguageClient_contextMenu()<CR>
"nnoremap <silent> <leader>h :call LanguageClient_textDocument_hover()<CR>


" COC
 "if hidden is not set, TextEdit might fail.
set hidden

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

"" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-r> for trigger completion.
inoremap <silent><expr> <c-r> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')


" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"vmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>c  <Plug>(coc-codeaction)

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" Add diagnostic info for airline
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
