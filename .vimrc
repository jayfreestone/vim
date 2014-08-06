set shortmess+=I

let mapleader=","
set nowrap
set number
set linespace=2 
set shiftwidth=2
set tabstop=2
set smartindent
set autoindent
set shiftwidth=2
set expandtab

set noswapfile

set hlsearch

let delimitMate_expand_cr = 1

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

colorscheme Tomorrow-Night-Eighties


let g:airline_powerline_fonts = 1
set laststatus=2

""""""""""""""""""""""""""""""
" airline
 let g:airline_theme             = 'tomorrow'
 let g:airline_enable_branch     = 1
 let g:airline_enable_syntastic  = 0
"
 " vim-powerline symbols
 let g:airline_left_sep          = '⮀'
 let g:airline_left_alt_sep      = '⮁'
 let g:airline_right_sep         = '⮂'
 let g:airline_right_alt_sep     = '⮃'
 let g:airline_branch_prefix     = '⭠'
 let g:airline_readonly_symbol   = '⭤'
 let g:airline_linecolumn_prefix = '⭡'


"nmap <C-/> <leader>c<Space>
"vmap <C-/> <leader>c<Space>
"
"" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>                                                                                                                       
nmap <silent> <c-j> :wincmd j<CR>                                                                                                                       
nmap <silent> <c-h> :wincmd h<CR>                                                                                                                       
nmap <silent> <c-l> :wincmd l<CR>

" <TAB>: completion.
 inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
 " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

map <C-d> :vsplit.<CR>

execute pathogen#infect()
syntax on
filetype plugin indent on

let g:session_autosave = 'yes'
let g:session_autoload = 'yes'

" Track the engine.
"Plugin 'bundle/ultisnips'
"let g:UltiSnipsSnippetsDir="~/.vim/bundle/ultisnips/UltiSnips"

" Snippets are separated from the engine. Add this if you want them:
"Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-E>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


let g:NERDCustomDelimiters = {
      \ 'liquid': { 'left': '{% comment%}', 'right': '{% endcomment %}'}
\ }

" syntastic
let g:syntastic_auto_loc_list=1
let g:syntastic_disabled_filetypes=['html', 'liquid']
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1
" ignore syntastic errors temporarily
map \t :SyntasticToggleMode<CR> :SyntasticToggleMode<CR>

set splitbelow
set splitright

let &path = getcwd() . '/**'

nnoremap <F5> :GundoToggle<CR>

vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"Make Ctrl-P plugin a lot faster for Git projects
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0

map cl <Plug>(easymotion-bd-f)
let g:EasyMotion_smartcase=1

autocmd BufRead,BufNewFile *.css,*.scss,*.less setlocal foldmethod=marker foldmarker={,}

let g:ctrlp_extensions = ['symbol']
