filetype plugin indent on
syntax on

call plug#begin('~/.vim/plugged')

" Plugins
Plug 'junegunn/vim-easy-align'
Plug 'ap/vim-buftabline'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'shawncplus/phpcomplete.vim'
Plug 'othree/html5.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'ternjs/tern_for_vim'
Plug 'w0ng/vim-hybrid'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tmhedberg/matchit'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'sjl/gundo.vim/'
Plug 'tpope/vim-repeat'
Plug 'nelsyeung/twig.vim'
Plug 'tokutake/twig-indent'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'rakr/vim-two-firewatch'
Plug 'editorconfig/editorconfig-vim'
Plug 'ervandew/ag'
Plug 'w0rp/ale'
Plug 'mhinz/vim-grepper'
Plug 'Shougo/neocomplete.vim'
Plug 'scrooloose/nerdtree'
Plug 'unblevable/quick-scope'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'cocopon/iceberg.vim'

if has("gui_running")
  Plug 'ctrlpvim/ctrlp.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
  Plug 'junegunn/fzf.vim'
endif

call plug#end()

set termguicolors

" Grepper
command! -nargs=* -complete=file GG Grepper -tool git -query <args>
command! -nargs=* Ag Grepper -noprompt -tool ag -grepprg ag --vimgrep <args> %

if has("gui_running")
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " Only look in current folder
    let g:ctrlp_working_path_mode = 0
  endif

  " CtrlP Buffer Search
  map <C-b> :CtrlPBuffer<CR>
  map <C-t> :CtrlPBufTag<CR>

  let g:ctrlp_buftag_types = {
    \ 'coffee': '',
    \ 'ghmarkdown': '',
    \ 'go': '',
    \ 'javascript': '',
    \ 'markdown': '',
    \ 'scss': ''
    \ }
else
  " FZF {{{
  " <C-p> or <C-t> to search files
  " nnoremap <silent> <C-p> :FZF -m<cr>
  
  " Gets around FZF overriding Ag command
  let g:fzf_command_prefix = 'Fzf'

  nnoremap <silent> <C-p> :call fzf#vim#files('',
        \ {'source': 'ag --hidden --ignore .git -f -g ""', 'down': '40%'})<cr>

  " <Ctrl-b> for open buffers
  nnoremap <silent> <C-b> :FzfBuffers<cr>

  " <Ctrl-b> for open buffers
  nnoremap <silent> <C-b> :FzfBuffers<cr>
	
  " <Ctrl-t> for buffer tags
  nnoremap <silent> <C-t> :FzfBTags<cr>

  " <M-S-p> for MRU
  nnoremap <silent> <M-S-p> :History<cr>

  " Ctag search
  function! s:tags_sink(line)
    let parts = split(a:line, '\t\zs')
    let excmd = matchstr(parts[2:], '^.*\ze;"\t')
    execute 'silent e' parts[1][:-2]
    let [magic, &magic] = [&magic, 0]
    execute excmd
    let &magic = magic
  endfunction

  function! s:tags()
    if empty(tagfiles())
      echohl WarningMsg
      echom 'Preparing tags'
      echohl None
      call system('ctags -R')
    endif

    call fzf#run({
	  \ 'source':  'cat '.join(map(tagfiles(), 'fnamemodify(v:val, ":S")')).
	  \            '| grep -v ^!',
	  \ 'options': '+m -d "\t" --with-nth 1,4.. -n 1 --tiebreak=index',
	  \ 'down':    '40%',
	  \ 'sink':    function('s:tags_sink')})
  endfunction

  command! Tags call s:tags()

  command! -bang -nargs=* Ack call fzf#vim#ag(<q-args>, {'down': '40%', 'options': --no-color'})
  " }}}
endif

" Color Scheme
set background=dark
colorscheme iceberg

" Set Rule
set colorcolumn=80

" Start EasyAlign
map <C-a> :EasyAlign<CR>

" Undo persists after closing/re-opening
set undofile
set undodir=~/.vim/undodir

" General Settings
let mapleader=","
set nowrap
set lazyredraw
set smartindent
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set nobackup
set backupcopy=no
set nowritebackup
set noswapfile
set cursorline
set incsearch  ignorecase  smartcase
set number
set laststatus=2

" Fix indentation on PHP files
autocmd BufRead,BufNewFile   *.html,*.php set shiftwidth=4 tabstop=4 noexpandtab

" Look for ctags all to the way up to the root
set tags+=tags;$HOME

" Folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Make jj do esc"
inoremap jj <Esc>

let g:AutoPairsMultilineClose = 0

" Easymotion Config
" <Leader>f{char} to move to {char}
map  <leader>f <Plug>(easymotion-bd-f)
nmap <leader>f <Plug>(easymotion-overwin-f)

" Opens the directory listing
map <C-d> :vsplit<CR>

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

" JSX Syntax Highlighting
let g:jsx_ext_required = 1 " Allow JSX in normal JS files"

" UltiSnips settings
let g:UltiSnipsExpandTrigger="<c-j>"

" Completion
" Don't select first result
set completeopt=menuone,longest
" Don't open the scratch window 
set completeopt-=preview
" Adds more sources for word completion
set complete=.,w,b,u,t,i

" Go to tag support for JS methods
" in ~/.vim/after/ftplugin/javascript.vim
nnoremap <buffer> <C-]> :tjump /<c-r>=expand('<cword>')<CR><CR>

" Disables all gitgutter keybindings
let g:gitgutter_map_keys = 0
" nmap <Leader>gs <Plug>GitGutterStageHunk
" nmap <Leader>gr <Plug>GitGutterUndoHunk

" WordProcessor Mode for text editing
func! WordProcessorMode() 
  setlocal formatoptions=1 
  setlocal noexpandtab 
  map j gj 
  map k gk
  setlocal spell spelllang=en_us 
  set thesaurus+=/Users/sbrown/.vim/thesaurus/mthesaur.txt
  set complete+=s
  set formatprg=par
  setlocal wrap 
  setlocal linebreak 
endfu 
com! WP call WordProcessorMode()

"set JS jump to definition to use ternjs
autocmd filetype javascript nmap <silent> gd :TernDef<CR>
autocmd filetype javascript nmap <silent> gD :TernDef<CR>

" Set up tern mapping
let g:tern_map_keys=1
let g:tern_map_prefix = '<leader>'

nnoremap <C-g> :GundoToggle<CR>

" allow the . to execute once for each line of a visual selection
vnoremap . :normal .<CR>

" Console log from insert mode; Puts focus inside parentheses
imap cll console.log();<Esc>==f(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap cll yocll<Esc>p
" Console log from normal mode, inserted on next line with word your on inside parentheses
nmap cll yiwocll<Esc>p 

set hlsearch
" Exit out of hlsearch
nnoremap <esc><esc> :noh<return><esc>

" Ensures Editorconfig works with Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

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
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType javascript setlocal omnifunc=tern#Complete
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.javascript = '\h\w*\|[^. \t]\.\w*'

"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

nmap <silent> <C-D> :NERDTreeToggle<CR>
nmap <silent> - :NERDTreeFind <CR>

" Trigger a quickscope highlight
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
let g:qs_first_occurrence_highlight_color = '#e3aa83'
let g:qs_second_occurrence_highlight_color = '#aebd85'

" Prefer :tjump over :tag
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>
