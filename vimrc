filetype plugin indent on
syntax on

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

function! BuildTern(info)
    if a:info.status == 'installed' || a:info.force
        !npm install
    endif
endfunction

" Plugins
Plug 'junegunn/vim-easy-align'
Plug 'ap/vim-buftabline'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'othree/html5.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'w0ng/vim-hybrid'
Plug 'tmhedberg/matchit'
Plug 'airblade/vim-gitgutter'
Plug 'sjl/gundo.vim/'
Plug 'tpope/vim-repeat'
Plug 'nelsyeung/twig.vim'
Plug 'tokutake/twig-indent'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'editorconfig/editorconfig-vim'
Plug 'mhinz/vim-grepper'
Plug 'tpope/vim-eunuch'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'justinmk/vim-sneak'
Plug 'rakr/vim-one'
Plug 'w0ng/vim-hybrid'
Plug 'christoomey/vim-tmux-navigator'
Plug 'liuchengxu/vista.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'

Plug 'junegunn/fzf.vim'

call plug#end()

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" True colors support
set termguicolors

" Enable mouse support
set mouse=n

set cmdheight=2

" Grepper
command! -nargs=* -complete=file GG Grepper -tool git -query <args>
command! -nargs=* Ag Grepper -noprompt -tool ag -grepprg ag --vimgrep <args> %

" Remove delay with Ctrl + [
" https://www.johnhawthorn.com/2012/09/vi-escape-delays/
set timeoutlen=1000 ttimeoutlen=0

" FZF

" Gets around FZF overriding Ag command
let g:fzf_command_prefix = 'Fzf'

if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
    nnoremap <C-f> :FzfRg<Cr>

    command! -bang -nargs=* Rg
                \ call fzf#vim#grep(
                \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
                \   fzf#vim#with_preview(), <bang>0)
endif

nnoremap <silent> <C-p> :call fzf#vim#files('',
            \ {'down': '40%'})<cr>

" <Ctrl-b> for open buffers
nnoremap <silent> <C-b> :FzfBuffers<cr>

" <Ctrl-t> for buffer tags
nnoremap <silent> <C-t> :FzfBTags<cr>

" Color Scheme
set background=dark
colorscheme dracula

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

" Folding
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" Clear word highlighting
nmap <esc><esc> :noh<return>

let g:AutoPairsMultilineClose = 0

" Fix for iTerm blocking pane movement
if has('nvim')
    nnoremap <bs> <C-w>h
endif

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

" Enables shift-tab for reverse indenting
" for command mode
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>

" Considers hyphens to be part of 'words'
set iskeyword+=-

" JSX Syntax Highlighting
let g:jsx_ext_required = 1 " Allow JSX in normal JS files"

" Completion
" Don't select first result
set completeopt=menuone,longest
" Don't open the scratch window
set completeopt-=preview
" Adds more sources for word completion
set complete=.,w,b,u,t,i

" Disables all gitgutter keybindings
let g:gitgutter_map_keys = 0
" nmap <Leader>gs <Plug>GitGutterStageHunk
" nmap <Leader>gr <Plug>GitGutterUndoHunk

let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Prefer :tjump over :tag
nnoremap <c-]> g<c-]>
vnoremap <c-]> g<c-]>

nnoremap <silent> K :call <SID>show_documentation()<CR>
inoremap <silent><expr> <c-space> coc#refresh()

" " Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

function! s:show_documentation()
    if &filetype == 'vim'
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
