set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'justinmk/vim-sneak'
Plugin 'tomtom/tcomment_vim'
Plugin 'kien/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'sudar/vim-wordpress-snippets'
Plugin 'honza/vim-snippets'
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-sensible'
Plugin 'captbaritone/better-indent-support-for-php-with-html'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'ervandew/ag'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'ervandew/supertab'
Plugin 'othree/html5.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'tomasr/molokai'

" Triggers popup completion menu with SuperTab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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

" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Opens the directory listing
map <C-d> :vsplit.<CR>

" Considers hyphens to be part of 'words'
set iskeyword+=-

" Hacky implementation of 'go to class'
map  <C-b> :Ag <C-R>=expand("<cword>")<CR> src/sass/**/*.scss<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Recommended Syntastic Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
map <leader>s :SyntasticCheck<CR>
let g:syntastic_php_phpcs_args="--report=csv --standard=WordPress-Extra"
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_quiet_messages = { "level": []  }
let g:syntastic_scss_checkers = ['scss_lint']
