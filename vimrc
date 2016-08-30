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
Plug 'ervandew/ag'
Plug 'shawncplus/phpcomplete.vim'
Plug 'othree/html5.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-vinegar'
Plug 'easymotion/vim-easymotion'
Plug 'ternjs/tern_for_vim'
Plug 'dsawardekar/wordpress.vim'
Plug 'w0ng/vim-hybrid'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tmhedberg/matchit'
Plug 'joshdick/onedark.vim'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'
Plug 'captbaritone/better-indent-support-for-php-with-html'
Plug 'sjl/gundo.vim/'
Plug 'tpope/vim-repeat'
Plug 'nelsyeung/twig.vim'
Plug 'tokutake/twig-indent'
Plug 'tpope/vim-sleuth'

if has('nvim')
  Plug 'benekastah/neomake'
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Valloric/YouCompleteMe'
  Plug 'scrooloose/syntastic'
endif

if has("gui_running")
  Plug 'ctrlpvim/ctrlp.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
  Plug 'junegunn/fzf.vim'
endif

call plug#end()

if has('nvim')
  " Disables Python 3 interpreter check
  let g:python3_host_skip_check = 1

  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_ignore_case = 'ignorecase'
  let g:deoplete#omni_patterns = {}
  let g:deoplete#omni_patterns.php =
	\ '\h\w*\|[^. \t]->\%(\h\w*\)\?\|\h\w*::\%(\h\w*\)\?'

  " Run Neocomplete on save
  autocmd! BufWritePost * Neomake
  " autocmd! BufWritePost,BufEnter * Neomake
  let g:neomake_open_list = 2
  let g:neomake_php_enabled_makers = ['phpcs']
  let g:neomake_php_phpcs_args_standard = 'WordPress-Core'
  let g:neomake_javascript_enabled_makers = ['eslint']
  let g:neomake_javascript_eslint_maker = {
	\ 'args': ['--no-color', '--format', 'compact', '--config', '~/.eslintrc'],
	\ 'errorformat': '%f: line %l\, col %c\, %m'
	\ }

  " Use system clipboard by default
  set clipboard+=unnamedplus

  " Enables true color
  " let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Temporary fix for neovim/neovim#2048
  " Shoutout to @vilhalmer for the idea for this fix
  " https://github.com/vilhalmer/System/commit/a40ff262918a83e88fb643bad31dde3c45211bba

  " Fix for window movement
  nmap <bs> <C-w>h
  " Fix for tab movement
  nmap <C-w><bs> :tabprevious<CR>

else
  " Syntastic Settings
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  map <s> <Nop>
  map <C-S> :SyntasticCheck<CR>

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_loc_list_height = 5
  let g:syntastic_auto_loc_list = 0
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_php_phpcs_args="--report=csv --standard=WordPress-Extra"
  let g:syntastic_html_checkers = ['w3']
  let g:syntastic_scss_checkers = ['']
  let g:syntastic_javascript_checkers = ['eslint']

  let g:syntastic_error_symbol = '❌'
  let g:syntastic_style_error_symbol = '⁉️'
  let g:syntastic_warning_symbol = '⚠️'
  let g:syntastic_style_warning_symbol = '💩'

  highlight link SyntasticErrorSign SignColumn
  highlight link SyntasticWarningSign SignColumn
  highlight link SyntasticStyleErrorSign SignColumn
  highlight link SyntasticStyleWarningSign SignColumn

endif

if has("gui_running")
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  endif

  " CtrlP Buffer Search
  map <C-b> :CtrlPBuffer<CR>
else
  " FZF {{{
  " <C-p> or <C-t> to search files
  " nnoremap <silent> <C-p> :FZF -m<cr>
  nnoremap <silent> <C-p> :call fzf#vim#files('',
        \ {'source': 'ag --hidden --ignore .git -f -g ""', 'down': '40%'})<cr>

  " <M-p> for open buffers
  nnoremap <silent> <C-b> :Buffers<cr>

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
colorscheme onedark

" Start EasyAlign
map <C-a> :EasyAlign<CR>

" Undo persists after closing/re-opening
set undofile
set undodir=~/.vim/undodir

" Statusline
set statusline=%<\ %f\ %{fugitive#statusline()}

" General Settings
let mapleader=","
set nowrap
set lazyredraw
set smartindent
set autoindent
set shiftwidth=2
set expandtab
set tabstop=2
set nobackup
set backupcopy=no
set nowritebackup
set noswapfile
set cursorline
set incsearch  ignorecase  smartcase
set number

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

" Sets up relative WP path for WP Vim
let g:wordpress_vim_wordpress_path="../../wordpress"

" Go to tag support for JS methods
" in ~/.vim/after/ftplugin/javascript.vim
nnoremap <buffer> <C-]> :tjump /<c-r>=expand('<cword>')<CR><CR>

" Disables all gitgutter keybindings
let g:gitgutter_map_keys = 0
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk

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
