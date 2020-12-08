set shell=bash\ -i

filetype off
set nocompatible

" Utility
call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'godlygeek/tabular'
Plug 'Townk/vim-autoclose'
Plug 'tobyS/vmustache'

" Git
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Fuzzy Finder
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" rust
Plug 'cespare/vim-toml'
Plug 'rust-lang/rust.vim'

" typescript / jsx
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'HerringtonDarkholme/yats.vim'


" Theme / Interface
Plug 'itchyny/lightline.vim'
Plug 'machakann/vim-highlightedyank'
Plug 'morhetz/gruvbox'
call plug#end()

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

set background=dark
colorscheme gruvbox

if has("mac") || has("macunix")
  set guifont=Monaco\ for\ Powerline:h24
elseif has("win64")
  set guifont=Monaco\ for\ Powerline:h14:cANSI
  set renderoptions=type:directx,renmode:5
endif

" Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'coc': 'coc#status'
      \ },
      \ 'active': {
      \   'right': [ ['coc'] ]
      \ },
      \ 'separator': {'left': '⮀', 'right': '⮂'},
      \ 'subseparator': {'left': '⮁', 'right': '⮃'}
\ }

function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" coc plugin
highlight CocErrorSign ctermfg=15 ctermbg=196
highlight CocWarningSign ctermfg=0 ctermbg=172

let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-rls'
  \ ]

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

" for auto-close plugin
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" file type definition
autocmd BufRead *.md set filetype=markdown

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

" trim spaces
autocmd BufWritePre * :%s/\s\+$//e

" JSX/TSX syntax highlight
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear

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
nmap <silent> <space>fmt <Plug>(coc-format)

" Mapping selecting Mappings
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

if get(g:, 'elite_mode')
  nnoremap <Up>    :resize +2<CR>
  nnoremap <Down>  :resize -2<CR>
  nnoremap <Left>  :vertical resize +2<CR>
  nnoremap <Right> :vertical resize -2<CR>
endif

map <F1> <Esc>
imap <F1> <Esc>
