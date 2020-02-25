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
Plug 'SirVer/ultisnips'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-surround'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'othree/html5.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'easymotion/vim-easymotion'
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
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'liuchengxu/vista.vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-vinegar'
Plug 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'branch': 'release/0.x'
            \ }

if has("gui_running")
    Plug 'ctrlpvim/ctrlp.vim'
else
    Plug '/usr/local/opt/fzf'
    Plug 'junegunn/fzf.vim'
endif

call plug#end()

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

set termguicolors

" Enable mouse support
set mouse=n

set cmdheight=2

" Grepper
command! -nargs=* -complete=file GG Grepper -tool git -query <args>
command! -nargs=* Ag Grepper -noprompt -tool ag -grepprg ag --vimgrep <args> %


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

" Color Scheme
set background=dark
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1
colorscheme hybrid

" Start EasyAlign
" map <C-a> :EasyAlign<CR>

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

" Look for ctags all to the way up to the root
set tags+=tags;$HOME

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

" Setup flow
let g:javascript_plugin_flow = 1

" UltiSnips settings
let g:UltiSnipsSnippetDirectories = ['UltiSnips', $HOME.'/.vim/UltiSnips']
let g:UltiSnipsExpandTrigger="<c-j>"

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

" Setup coc
let g:coc_global_extensions = ['coc-emoji', 'coc-eslint', 'coc-prettier', 'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin', 'coc-css', 'coc-json', 'coc-pyls', 'coc-yaml']

function! CocCurrentFunction()
    return get(b:, 'coc_current_function', '')
endfunction

" Use K for show documentation in preview window
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
