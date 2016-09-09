set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround

set nu
set hlsearch
syntax on

set nocompatible
filetype off
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Support bundles
NeoBundle 'tpope/vim-vinegar'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'moll/vim-bbye'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }

" Git
NeoBundle 'tpope/vim-fugitive'

" Bars, panels, and files
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'

" Text manipulation
NeoBundle 'vim-scripts/Gundo'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tommcdo/vim-lion'
NeoBundle 'michaeljsmith/vim-indent-object'

" Haskell
NeoBundle 'enomsg/vim-haskellConcealPlus'
NeoBundle 'dag/vim2hs'
" NeoBundle 'neovimhaskell/haskell-vim'
NeoBundle 'Twinside/vim-hoogle'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'

" Colorscheme
NeoBundle 'vim-scripts/wombat256.vim'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'jnurmine/Zenburn'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'chriskempson/base16-vim'

" Golang
NeoBundle 'fatih/vim-go'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" Completions
let g:neocomplete#enable_at_startup = 0
let g:neocomplete#enable_smart_case = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'haskell'] }

let mapleader = ","
set wildmenu

" Airline
set laststatus=2
let g:airline_powerline_fonts = 1

" Swap files
set swapfile
set dir=~/.vim/tmp

" Colors
let base16colorspace=256
set background=dark

" Haskell
let g:haskellmode_completion_ghc = 0
let g:necoghc_enable_detailed_browse = 1
" let g:haskell_conceal_wide = 1
let g:syntastic_haskell_checkers = []
au FileType haskell setlocal omnifunc=necoghc#omnifunc
au FileType haskell nmap <leader>t :GhcModType<CR>
au FileType haskell nmap <leader>cl :GhcModCheckAndLintAsync<CR>
au FileType haskell nmap <leader>cg :GhcModSigCodeGen<CR>
au FileType haskell nmap <leader>sc :GhcModSigCodeGen<CR>

" Golang
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>gd <Plug>(go-doc)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
