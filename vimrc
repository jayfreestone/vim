syntax on
set background=dark
let g:hybrid_custom_term_colors = 1
colorscheme hybrid

set encoding=utf8
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')

" Plugins
Plug 'junegunn/vim-easy-align'
Plug 'ap/vim-buftabline'
Plug 'tomtom/tcomment_vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'ervandew/ag'
Plug 'shawncplus/phpcomplete.vim'
Plug 'othree/html5.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'mxw/vim-jsx'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-vinegar'
Plug 'chip/vim-fat-finger'
Plug 'easymotion/vim-easymotion'

if has('nvim')
	Plug 'Shougo/deoplete.nvim'
	Plug 'benekastah/neomake'
endif


call plug#end()

" Start EasyAlign
map <C-a> :EasyAlign<CR>

" Statusline
set statusline=%<\ %f\ %{fugitive#statusline()}

" General Settings
let mapleader=","
set nowrap
set lazyredraw
set number
set linespace=2 
set shiftwidth=2
set tabstop=4
set smartindent
set autoindent
set shiftwidth=4
set noexpandtab
set nobackup
set nowritebackup
set noswapfile
set cursorline
set incsearch  ignorecase  smartcase
set autowrite
set autowriteall

" Folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

"make jj do esc"
inoremap jj <Esc>

let g:AutoPairsMultilineClose = 0

if has('nvim')
	" Disables Python 3 interpreter check
	let g:python3_host_skip_check = 1

	" Run Neocomplete on save
	autocmd! BufWritePost,BufEnter * Neomake
	let g:neomake_open_list = 2
	let g:neomake_php_enabled_makers = ['phpcs']
	let g:neomake_php_phpcs_args_standard = 'WordPress-Core'

	" Handle Deoplete
	let g:deoplete#enable_at_startup = 1
endif


" Easymotion Config
" <Leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <leader>L <Plug>(easymotion-bd-jk)
nmap <leader>L <Plug>(easymotion-overwin-line)

" Opens the directory listing
map <C-d> :vsplit<CR>

"map <C-p> :FZF<CR>

" FZF Configuration
if executable('fzf')
  " FZF {{{
  " <C-p> or <C-t> to search files
  nnoremap <silent> <C-p> :FZF -m<cr>

  " <M-p> for open buffers
  nnoremap <silent> <C-b> :Buffers<cr>

  " <M-S-p> for MRU
  nnoremap <silent> <M-S-p> :History<cr>

  " Use fuzzy completion relative filepaths across directory
  imap <expr> <c-x><c-f> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

  " Better command history with q:
  command! CmdHist call fzf#vim#command_history({'right': '40'})
  nnoremap q: :CmdHist<CR>

  command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
  " }}}
else
  " CtrlP fallback
end

filetype plugin indent on    " required


" Buffers
set hidden
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

if has('nvim')
     " Temporary fix for neovim/neovim#2048
     " Shoutout to @vilhalmer for the idea for this fix
     " https://github.com/vilhalmer/System/commit/a40ff262918a83e88fb643bad31dde3c45211bba
     "
     " Fix for window movement
     nmap <bs> <C-w>h
     " Fix for tab movement
     nmap <C-w><bs> :tabprevious<CR>
 endif

" Considers hyphens to be part of 'words'
set iskeyword+=-

" Hacky implementation of 'go to Sass class'
map  <C-t> :Ag <C-R>=expand("<cword>")<CR> src/**/**/*.scss<CR>

" JSX Syntax Highlighting
let g:jsx_ext_required = 0 " Allow JSX in normal JS files"

" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
