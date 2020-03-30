set shell=bash\ -i

filetype off
set nocompatible
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#rc()

Plugin 'vundlevim/vundle.vim'

" Utility
Plugin 'ciaranm/securemodelines'
Plugin 'scrooloose/nerdtree'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'benmills/vimux'
Plugin 'Townk/vim-autoclose'
Plugin 'tobyS/vmustache'
Plugin 'janko-m/vim-test'

" Git
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" Fuzzy Finder
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'

" Markdown
Plugin 'plasticboy/vim-markdown'
Plugin 'suan/vim-instant-markdown'

" Completion
Plugin 'ncm2/ncm2'
Plugin 'roxma/nvim-yarp'
Plugin 'ncm2/ncm2-bufword'
Plugin 'ncm2/ncm2-path'
Plugin 'ncm2/ncm2-tmux'
Plugin 'ncm2/ncm2-racer'
Plugin 'autozimu/LanguageClient-neovim', {
  \ 'branch': 'next',
  \ 'do': 'bash install.sh',
\ }

" Programming Support
" js / vuejs
Plugin 'trkw/yarn.vim'
Plugin 'posva/vim-vue'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
" ts
Plugin 'leafgarland/typescript-vim'
" java
" *TODO* add me plugin!

" rust
Plugin 'cespare/vim-toml'
Plugin 'rust-lang/rust.vim'
Plugin 'rhysd/rust-doc.vim'

" Theme / Interface
Plugin 'itchyny/lightline.vim'
Plugin 'w0rp/ale'
Plugin 'machakann/vim-highlightedyank'
Plugin 'morhetz/gruvbox'

filetype plugin indent on

set encoding=utf-8

set autoindent
set expandtab
set nolist
set noswapfile
set noshowmode
set nojoinspaces
set signcolumn=yes
set hidden
syntax on

set undodir=~/.vimdid
set undofile

let g:elite_mode = 1

set colorcolumn=100
set showcmd
set virtualedit=onemore
set showmatch
set wildmode=list:longest


" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

set number
set ruler

set list listchars=tab:\▸\-
set smarttab
set tabstop=2
set shiftwidth=2
set laststatus=2

"set cursorline

set t_Co=256
set background=dark
colorscheme gruvbox

if has("mac") || has("macunix")
  set guifont=Monaco\ for\ Powerline:h24
elseif has("win64")
  set guifont=Monaco\ for\ Powerline:h14:cANSI
  set renderoptions=type:directx,renmode:5
endif

let g:secure_modelines_allowed_items = [
                \ "textwidth",   "tw",
                \ "softtabstop", "sts",
                \ "tabstop",     "ts",
                \ "shiftwidth",  "sw",
                \ "expandtab",   "et",   "noexpandtab", "noet",
                \ "filetype",    "ft",
                \ "foldmethod",  "fdm",
                \ "readonly",    "ro",   "noreadonly", "noro",
                \ "rightleft",   "rl",   "norightleft", "norl",
                \ "colorcolumn"
                \ ]


let g:LanguageClient_serverCommands = {
  \ 'vue': ['vls'],
  \ 'rust': ['rls'],
\ }

"Open NERDtree when open tab
"autocmd VimEnter * NERDTree

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ },
      \ 'separator': {'left': '⮀', 'right': '⮂'},
      \ 'subseparator': {'left': '⮁', 'right': '⮃'}
\ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" for auto-close plugin
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" rust
let $RUST_SRC_PATH                 = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"
let g:rustfmt_command              = "rustfmt +nightly"
let g:rustfmt_autosave             = 1
let g:rustfmt_emit_files           = 1
let g:rustfmt_fail_silently        = 0
"let g:rust_doc#downloaded_rust_doc_dir = '/Users/apple/.rustup/toolchains/nightly-x86_64-apple-darwin'

" markdown
let g:vim_markdown_folding_disabled     = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_auto_insert_bullets  = 0
let g:vim_markdown_frontmatter          = 1
let g:vim_markdown_toml_frontmatter     = 1

" Disable manually
" command: InstantMarkdownPreview
"let g:instant_markdown_autostart = 0

autocmd BufRead *.md set filetype=markdown

" Linter - only lint on save
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_save         = 1
let g:ale_lint_on_enter        = 0
let g:ale_virtualtext_cursor   = 1
let g:ale_rust_rls_toolchain   = ''
let g:ale_linters              = { 'vue': ['vls'], 'rust': ['rls']}
let g:ale_rust_rls_config = {
  \ 'rust': {
    \ 'all_targets': 1,
    \ 'build_on_save': 1,
    \ 'clippy_preference': 'on'
  \ }
\ }
highlight link ALEWarningSign Todo
highlight link ALEErrorSign WarningMsg
highlight link ALEVirtualTextWarning Todo
highlight link ALEVirtualTextInfo Todo
highlight link ALEVirtualTextError WarningMsg
highlight ALEError guibg=None
highlight ALEWarning guibg=None
let g:ale_sign_error   = "✖"
let g:ale_sign_warning = "⚠"
let g:ale_sign_info    = "i"
let g:ale_sign_hint    = "➤"

" Vim-Test Configuration
let test#strategy = "vimux"

" Fzf Configuration
" This is the default extra key bindings
let g:fzf_action = {
\ 'ctrl-t': 'tab split',
\ 'ctrl-x': 'split',
\ 'ctrl-v': 'vsplit'
\ }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'down': '~20%' }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" Customize fzf colors to match your color scheme
let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment']
\ }

" previous-history instead of down and up
" If you don't like the change, explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" <leader>s for Rg search
noremap <leader><tab> :Rg

"Rg search
""noremap <leader><tab> :Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" https://stackoverflow.com/questions/11916898/vim-is-it-possible-to-view-pdf-file-in-a-split-window
" for windows, use this library
" https://github.com/4U6U57/wsl-open
if has("mac") || has("macunix")
  augroup nonvim
     au!
     au BufRead *.png,*.jpg,*.pdf,*.gif,*.xls* sil exe "!open " . shellescape(expand("%:p")) | bd | let &ft=&ft
     au BufRead *.ppt*,*.doc*,*.rtf let g:output_pdf = shellescape(expand("%:r") . ".pdf")
     au BufRead *.ppt*,*.doc*,*.rtf sil exe "!/usr/local/bin/any2pdf " . shellescape(expand("%:p"))
     au BufRead *.ppt*,*.doc*,*.rtf sil exe "!open " . g:output_pdf | bd | let &ft=&ft
  augroup end
endif

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.vue setlocal expandtab shiftwidth=2
augroup END

autocmd BufWritePre * :%s/\s\+$//e

""""""""""""""""""""""""""""""""""""""""
" key bindings
""""""""""""""""""""""""""""""""""""""""
let mapleader = "\<Space>"

" ; as :
nnoremap ; :
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

noremap <C-q> :confirm qall<CR>

nnoremap j gj
nnoremap k gk

nmap <leader>w :w<CR>
nmap <Esc><Esc> :nohlsearch<CR><Esc>

map <C-n> :NERDTreeToggle<CR>
map <C-m> :TagbarToggle<CR>
map <C-p> :Files<CR>

" Completion
set shortmess+=c
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Mapping selecting Mappings
"nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

if get(g:, 'elite_mode')
  nnoremap <Up>    :resize +2<CR>
  nnoremap <Down>  :resize -2<CR>
  nnoremap <Left>  :vertical resize +2<CR>
  nnoremap <Right> :vertical resize -2<CR>
endif

"map <silent> <leader>ws :highlight clear ExtraWhitespace<CR>

nnoremap <silent> gl :ALEHover<CR>
noremap <silent> gk :ALEGoToDefinition<CR>

map <F1> <Esc>
imap <F1> <Esc>
