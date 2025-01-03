" Future plugins
" https://lazy.folke.io for plugin management
" https://github.com/folke/trouble.nvim/tree/dev
"

set nocompatible
filetype off
let mapleader=","
set t_Co=256

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'                 " File explorer
Plug 'hoob3rt/lualine.nvim'                " Bottom line
Plug 'akinsho/nvim-bufferline.lua'         " Shows buffers uptop
Plug 'simnalamburt/vim-mundo'              " TODO Replace this https://github.com/debugloop/telescope-undo.nvim
Plug 'scrooloose/nerdcommenter'            " Auto comment  based on language TODO use https://github.com/numToStr/Comment.nvim
Plug 'junegunn/vim-easy-align'             " Allign text
Plug 'Lokaltog/vim-easymotion'             " Jump to given word
Plug 'kien/ctrlp.vim'                      " File/buffer fuzzy search TODO use telescope
Plug 'vim-scripts/Figlet.vim'              " Insert figlets - BOLD TEXT
Plug 'mhinz/vim-signify'                   " Show line changes based on VCS
Plug 'tpope/vim-fugitive'                  " Git Wrapper
Plug 'tpope/vim-rhubarb'                   " GBrowse to open up GitHub
Plug 'kshenoy/vim-signature'               " Add and visualize marks
Plug 'moll/vim-bbye'                       " Move between buffers and delete current buffer: bd, bn, bp
Plug 'christoomey/vim-tmux-navigator'      " Move between vim and tmux panes seamlessly
Plug 'gabesoft/vim-ags'                    " Ag search
Plug 'nvim-lua/plenary.nvim'               " lua helpers. I assume other things need this TODO delete and find out
Plug 'folke/todo-comments.nvim'            " Highlights todo icons
Plug 'nvim-tree/nvim-web-devicons'         " Icons
Plug 'folke/trouble.nvim'                  " Show LSP Diagnostic errors
Plug 'ray-x/go.nvim'                       " Vim + Go
Plug 'ray-x/guihua.lua'                    " Needed for go.nvim...
Plug 'lukas-reineke/indent-blankline.nvim' " Shows indent levels
Plug 'mfussenegger/nvim-dap'               " Debug Adapater Protocol (dlv)
Plug 'rcarriga/nvim-dap-ui'                " Default UI for dlv
Plug 'OXY2DEV/markview.nvim'               " Markdown preview: Markiew

" LSP
"Plug 'nvim-lua/lsp-status.nvim' " TODO Delete?
Plug 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' " Shows diagnostic errors in a floating window

" Completions
" Eventually switch to: github.com/Saghen/blink.cmp
Plug 'hrsh7th/nvim-cmp'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

" For vsnip users.
Plug 'hrsh7th/cmp-vsnip'

" Snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Colors
Plug 'ayu-theme/ayu-vim'
Plug 'Mofiqul/dracula.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/completion-treesitter'

" Copilot
Plug 'github/copilot.vim'

call plug#end()

" Light colorscheme
let ayucolor="light"
"colorscheme ayu

" Dark Colorscheme
set termguicolors
colorscheme dracula

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
set noexpandtab
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

" More history
set history=10000
set undolevels=1000

" Clear whitespace at the end of lines automatically
autocmd BufWritePre * :%s/\s\+$//e

" Easy-align
vnoremap <silent> <leader>a :EasyAlign<Enter>

" CtrlP
set wildignore+=*/ui
let g:ctrlp_extensions = ['tag', 'buffertag', 'undo', 'changes']
map <C-p> :CtrlP<Enter>
map <C-b> :CtrlPBuffer<Enter>
map <C-s> :CtrlPTag<Enter>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]vendor$',
  \ }

" LuaLine
lua <<EOF
require('lualine').setup {
  options = {
    theme = 'dracula-nvim',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_x = {
      {
        'diff',
        colored = true, -- displays diff status in color if set to true
        -- all colors are in format #rrggbb
        color_added = '#46c726', -- changes diff's added foreground color
        color_modified = nil, -- changes diff's modified foreground color
        color_removed = nil, -- changes diff's removed foreground color
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      }
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {
    'nerdtree',
    'fugitive',
  },
}
EOF

" BufferLine
lua <<EOF
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
  }
}
EOF

" Signify
nnoremap <leader>gt :SignifyToggle<CR>
nnoremap <leader>gh :SignifyToggleHighlight<CR>
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
let g:signify_mapping_toggle_highlight = '<leader>gh'

" NerdTree
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
map <leader>e :NERDTreeFind<CR>
nmap <leader>nt :NERDTreeFind<CR>
let NERDTreeIgnore=['\.class', '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '\.o']
let NERDTreeQuitOnOpen=1

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Snippets
"
let g:completion_enable_snippet = 'vim-vsnip'

" Avoid showing message extra message when using completion
set shortmess+=c

" Add parenthesis to completions
let completion_enable_auto_paren = 1

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
  end

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
    mapping = {

	  ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif vim.fn["vsnip#available"](1) == 1 then
          feedkey("<Plug>(vsnip-expand-or-jump)", "")
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),

      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.fn["vsnip#jumpable"](-1) == 1 then
          feedkey("<Plug>(vsnip-jump-prev)", "")
        end
      end, { "i", "s" }),

      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      --{ name = 'vsnip' },
    }, {
      --{ name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require("cmp_nvim_lsp").default_capabilities()
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig')['gopls'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['jsonls'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['ruby_lsp'].setup {
    capabilities = capabilities
  }
EOF

" gopls
lua <<EOF
  lspconfig = require("lspconfig")
  lspconfig.gopls.setup {
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
		codelenses = {
          test = true,
		  tidy = true,
		},
        staticcheck = true,
		usePlaceholders = true,
      },
    },
  }

 vim.api.nvim_create_autocmd("BufWritePre", {
   pattern = { "*.go" },
   callback = function()
		local params = vim.lsp.util.make_range_params()
		params.context = {only = {"source.organizeImports"}}
		-- buf_request_sync defaults to a 1000ms timeout. Depending on your
		-- machine and codebase, you may want longer. Add an additional
		-- argument after params if you find that you have to write the file
		-- twice for changes to be saved.
		-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
		local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
		for cid, res in pairs(result or {}) do
		  for _, r in pairs(res.result or {}) do
			if r.edit then
			  local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
			  vim.lsp.util.apply_workspace_edit(r.edit, enc)
			end
		  end
		end
		vim.lsp.buf.format({async = false})
   end,
 })
EOF

" ruby-lsp
lua <<EOF
  local lspconfig = require('lspconfig')
  lspconfig.ruby_lsp.setup({
  init_options = {
    formatter = 'standard',
    linters = { 'standard' },
  },
 })
EOF

" LSP Mappings
" -- See `:help vim.diagnostic.*` for documentation on any of the below functions
lua <<EOF
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls', 'ruby_lsp' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
  }
end
EOF


" Treesitter highligting
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  ignore_install = { "phpdoc" },
  highlight = {
    enable = true,
  },
  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = true },
  },
}
EOF

" Highlights TODO FIXME BUG etc comments
lua << EOF
  require("todo-comments").setup {}
EOF

" LSP Trouble
lua << EOF
  require("trouble").setup {}

  local signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " "
  }

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
  end
EOF

" NVIM Dev Icons
lua << EOF
  require'nvim-web-devicons'.setup {
    default = true;
	color_icons = true;
  }
EOF

" LSP lines
lua <<EOF
  require("lsp_lines").setup()
  vim.diagnostic.config({
    virtual_text = false,
  })
EOF

" go.nvim
lua <<EOF
	require('go').setup()
EOF

" indent-blankline
" Shows lines at different indent levels
lua <<EOF
	require("ibl").setup()
EOF

" Copilot
lua <<EOF
	vim.g.copilot_no_tab_map = true vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
EOF
