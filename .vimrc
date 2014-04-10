set nocompatible
filetype off
let mapleader=","
set t_Co=256

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" My Bundles
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'bling/vim-airline'
Bundle 'sjl/gundo.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle "godlygeek/tabular"
Bundle 'junegunn/vim-easy-align'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'justinmk/vim-sneak'
Bundle 'kien/ctrlp.vim'
Bundle 'dantler/vim-alternate'
Bundle 'flazz/vim-colorschemes'
Bundle 'Shougo/neocomplete.vim'
Bundle 'vim-scripts/Figlet.vim'
Bundle 'mileszs/ack.vim'
Bundle 'mhinz/vim-signify'
Bundle 'Pychimp/vim-luna'
Bundle 'kshenoy/vim-signature'
Bundle 'jnwhiteh/vim-golang'
Bundle 'leshill/vim-json'
Bundle 'moll/vim-bbye'

if has("gui_running")
    colorscheme luna
else
    colorscheme luna-term
endif

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

" White space highlighting
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

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

" MISC
set shortmess+=filmnrxoOtT " Abbreviate and avoid hit enter
set virtualedit=onemore    " Allow for cursor beyond last character
imap jj <Esc>
set wildmenu
set wildignore+=*.o,*.so,*.swp,*.zip,*.class,*.pyc
set autowriteall " Automatically writes when switching buffers 
set updatetime=4000

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

" Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" Airline
set laststatus=2
let g:airline_theme='luna'
let g:signify_mapping_toggle_highlight = '<leader>gh'
let g:airline#extensions#tabline#enabled = 1

" Easy-align
vnoremap <silent> <leader>a :EasyAlign<Enter>

" TagBar
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" Syntastic
let g:syntastic_c_check_header = 1
let g:syntastic_c_compiler_options = '-std=gnu99 -fno-strict-aliasing 
            \-Werror -Wall -Wno-missing-field-initializers 
            \-Wmissing-declarations -Wmissing-prototypes -Wno-format-zero-length 
            \-Wpointer-arith 
            \-Wstrict-prototypes -Wwrite-strings -Werror=unused-function'

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="E501,E302,E261,E701,E241,E126,E127,E128,W801"'

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeIgnore=['\.class', '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeQuitOnOpen=1

" Cscope
nmap <leader>s :cs find s <C-R>=expand("<cword>")<CR><CR>
set cscopetag

"Neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 15
let g:neocomplete#force_overwrite_completefunc = 1

" SuperTab like snippets behavior.
imap <silent><expr><TAB> neosnippet#expandable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
            \ "\<C-e>" : "\<TAB>")
smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \ 'scheme' : $HOME.'/.gosh_completions'
            \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.

" These two lines conflict with the default digraph mapping of <C-K>
" If you prefer that functionality, add
" let g:spf13_no_neosnippet_expand = 1
" in your .vimrc.bundles.local file

if !exists('g:spf13_no_neosnippet_expand')
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
endif

inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()
inoremap <expr><CR> neocomplete#complete_common_string()

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

" <CR>: close popup
" <s-CR>: close popup and save indent.
inoremap <expr><s-CR> pumvisible() ? neocomplete#close_popup()"\<CR>" : "\<CR>"
inoremap <expr><CR> pumvisible() ? neocomplete#close_popup() : "\<CR>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Haskell post write lint and check with ghcmod
" $ `cabal install ghcmod` if missing and ensure
" ~/.cabal/bin is in your $PATH.
if !executable("ghcmod")
    autocmd BufWritePost *.hs GhcModCheckAndLintAsync
endif

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'

" Use honza's snippets.
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

" Enable neosnippet snipmate compatibility mode
let g:neosnippet#enable_snipmate_compatibility = 1

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
set completeopt-=preview

" GO Syntax
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on

autocmd BufWritePre *.go Fmt " Auto format on saves
