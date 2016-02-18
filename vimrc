set encoding=utf8
set nocompatible
filetype off

" Include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'ap/vim-buftabline'
Plugin 'justinmk/vim-sneak'
Plugin 'tomtom/tcomment_vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'captbaritone/better-indent-support-for-php-with-html'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'ervandew/ag'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'othree/html5.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'jordwalke/AutoComplPop'
Plugin 'jordwalke/VimCompleteLikeAModernEditor'
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimfiler.vim'
Plugin 'chip/vim-fat-finger'

let g:AutoPairsMultilineClose = 0

" Use VimFiler over netrw
:let g:vimfiler_as_default_explorer = 1
" Opens the directory listing
map <C-d> :VimFiler<CR>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Vim Sneak settings
let g:sneak#streak = 1

" General Settings
let mapleader=","
set nowrap
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

" Buffers
set hidden
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprev<CR>

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Considers hyphens to be part of 'words'
set iskeyword+=-

" Hacky implementation of 'go to Sass class'
map  <C-b> :Ag <C-R>=expand("<cword>")<CR> src/sass/**/*.scss<CR>

" Use The Silver Searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
map <leader>s :SyntasticCheck<CR>
"let g:syntastic_php_phpcs_args="--report=csv --standard=WordPress-Extra"
" let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_php_checkers=['php']
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_quiet_messages = { "level": []  }
let g:syntastic_scss_checkers = ['']

" JSX Syntax Highlighting
let g:jsx_ext_required = 0 " Allow JSX in normal JS files"

" UltiSnips settings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

