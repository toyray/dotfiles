set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

"" Vim appearance plugins
Plugin 'gcmt/taboo.vim'
Plugin 'vim-scripts/ScrollColors'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tomasr/molokai'

"" Editing plugins
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'tpope/vim-endwise'

"" Navigation and search plugins
" Type <Leader>\* to search for word under cursor
Plugin 'bronson/vim-visual-star-search'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

"" Syntax plugins
Plugin 'scrooloose/nerdcommenter.git'
Plugin 'scrooloose/syntastic'

" Git plugins
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'gregsexton/gitv'

" Go plugins
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'

call vundle#end()

syntax enable
set encoding=utf-8
set showcmd
set number
set hidden
set wildmenu
set ttimeout
set ttimeoutlen=100
filetype plugin indent on
set noswapfile
set shell=bash\ -l

"" Whitespace
set nowrap
set tabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Display
set splitright
set splitbelow
set laststatus=2
set scrolloff=3
set sidescrolloff=5

"" Colors
set t_Co=256
colorscheme molokai

"" *** PLUGIN SETTINGS ***

"" ctrlp.vim
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 0

"" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go', 'env'] }

"" taboo.vim
let g:taboo_tabline = 0

"" ultisnips
" Update the go snippets via :UltiSnipsAddFiletypes go, :UltiSnipsEdit and
" copy snippets from https://github.com/fatih/vim-go/blob/master/gosnippets/UltiSnips/go.snippets

let g:UltiSnipsExpandTrigger='<tab>'

"" vim-airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline_theme="luna"

"" vim-go
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
let g:go_auto_sameids = 0
let g:go_auto_type_info = 1

"" *** KEYMAPS ***

" Leader is now comma
let mapleader=","
" Toggle line numbers
noremap <Leader>n :set invnumber<CR>
" Disable cursor keys
noremap <Left>  <NOP>
noremap <Right> <NOP>
noremap <Up>    <NOP>
noremap <Down>  <NOP>
" Navigate quickfix list
noremap <Leader>; :cp<CR>
noremap <Leader>' :cn<CR>
noremap <Leader>: :cclose<CR>
" Switch between windows
noremap <Leader>w <C-w>w
" Hide search highlights
nnoremap <silent> <Space> :noh<CR>
" Temporarily open an shell, type exit to return to vim
nnoremap <Leader>s :sh<CR>
" Switch between tabs
noremap <Leader>[ :tabprev<CR>
noremap <Leader>] :tabnext<CR>
" Close all windows except current
nnoremap <Leader>qw :only<CR>
" Close all tabs except current
nnoremap <Leader>qt :tabonly<CR>
" Edit ~/.vimrc in new tab
nnoremap <silent> <Leader>vimrc :tabe $MYVIMRC<CR>
" (TODO) Edit new file and set local directory
noremap <Leader><Tab> :tabe<CR>:lcd<space>
" (TODO) Paste line above or below
noremap <Leader>P "0P
noremap <Leader>p "0p
" (TODO) Split current file vertically
nnoremap <Leader>v :vs<CR><C-w>=
" (TODO) Split vertically with new file
nnoremap <Leader>vn :vnew<CR><C-w>=
" (TODO) Move current window to top left
nnoremap <Leader>ww <C-w>H<C-w>=
" (TODO) Open alternate buffer in window
nnoremap <Leader>b :b#<CR>
" (TODO) Insert one line above
nmap K i<Enter><Esc>
" (TODO) Vertically split and open alternate buffer
nmap <Leader>vb <Leader>v<Leader>b
" (TODO) Navigate between windows
noremap <silent> <Leader><Leader>h <C-w>h
noremap <silent> <Leader><Leader>j <C-w>j
noremap <silent> <Leader><Leader>k <C-w>k
noremap <silent> <Leader><Leader>l <C-w>l

"" *** PLUGIN KEYMAPS ***

"" nerdtree

" Open navigator
noremap <Leader>nt :NERDTreeFind<CR>
" (TODO) Toggle navigator, maybe <Leader>qw is more efficient?
noremap <Leader>ntt :NERDTreeToggle<CR>

"" nerdcommenter

" Toggle line comment
map <Leader>/ <Plug>NERDCommenterToggle
" (TODO) Other less-used NERDCommenter functionality
map <Leader>// <Plug>NERDCommenterYank
map <Leader>/b <Plug>NERDCommenterAlignLeft

"" vim-fugitive
" git diff current file
nnoremap <Leader>gd :Gdiff<CR>
" git log current fil
nnoremap <Leader>gl :Glog<CR>

"" vim-trailing-whitespace
" Remove trailing whitespaces
nnoremap <Leader>dw :FixWhitespace<CR>

"" vim-go

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

au Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
au Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
au Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
au Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

au FileType go nmap <Leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <Leader>r <Plug>(go-run)
au FileType go nmap <Leader>t <Plug>(go-test)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au Filetype go nmap <Leader>a :AV<CR>
au FileType go nmap <Leader>d <Plug>(go-decls)

"" gitv
" (TODO) Browse git version history
nnoremap <Leader>gv :Gitv<CR>

"" ctrlp.vim
" (TODO) Open CtrlP to search buffers
nnoremap <Leader>bb :CtrlPBuffer<CR>

"" *** RUNTIME! ***
" Press  % to navigate beween brace/bracket pairs
runtime! macros/matchit.vim

"" *** AUTOMAGIC ***
augroup reload_vimrc " {
  au!
  au BufWritePost $MYVIMRC source $MYVIMRC | :AirlineRefresh
augroup END " }
