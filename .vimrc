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

set nobackup
set nowritebackup
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

map <C-d> :vsplit.<CR>

execute pathogen#infect()
syntax on
filetype plugin indent on

" let g:session_autosave = 'yes'
" let g:session_autoload = 'yes'

" Track the engine.
"Plugin 'bundle/ultisnips'
"let g:UltiSnipsSnippetsDir="~/.vim/bundle/ultisnips/UltiSnips"

" Snippets are separated from the engine. Add this if you want them:
"Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-E>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

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

"Neocomplete
"
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" " Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
"
" " Define dictionary.
" let g:neocomplete#sources#dictionary#dictionaries = {
"     \ 'default' : '',
"     \ 'vimshell' : $HOME.'/.vimshell_hist',
"     \ 'scheme' : $HOME.'/.gosh_completions'
"         \ }
"
" " Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
"     let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
" " Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
" inoremap <expr><C-l>     neocomplete#complete_common_string()
"
" " Recommended key-mappings.
" " <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return neocomplete#close_popup() . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction
" " <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" " Close popup by <Space>.
" "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"
"
" " AutoComplPop like behavior.
" "let g:neocomplete#enable_auto_select = 1
"
" " Enable omni completion.
" autocmd FileType css,scss setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
"
" " Enable heavy omni completion.
" " if !exists('g:neocomplete#sources#omni#input_patterns')
" "   let g:neocomplete#sources#omni#input_patterns = {}
" " endif
" " let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
" "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
" "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"
"
""""""""""""


" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'


" My preference with using buffers. See `:h hidden` for more details
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>
