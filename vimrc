set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent on
syntax on
set tabstop=3
set softtabstop=3
set shiftwidth=3
set expandtab

set number relativenumber
" set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/fzf.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'jiangmiao/auto-pairs'
"Plugin 'Chiel92/vim-autoformat'
Plugin 'ctrlpvim/ctrlp.vim'


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" " Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Install L9 and avoid a Naming conflict if you've already installed a
" " different version somewhere else.
" " Plugin 'ascenator/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
"
"
" status plugin
set laststatus=2
"
"
map <C-o> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" update vim-gutter to 100ms
set updatetime=100

" set :Autoformat command to <F3>
noremap <F3> :Autoformat<CR>

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
"
set timeout ttimeoutlen=50
" Map tab to go to next window when split
map <M-Tab> <C-W>w

let mapleader = ","
"
" Moving lines around and selections
" Normal mode
"
nnoremap <Leader>k :m-2<CR>==
nnoremap <Leader>j :m+<CR>==
"
" Insert mode
"
inoremap <Leader>j <Esc>:m +.1<CR>==gi
inoremap <Leader>k <Esc>:m -.2<CR>==gi
" 
" Visual mode
"
vnoremap <Leader>j <Esc>'<,'>:m '>+1<CR>gv=gv
vnoremap <Leader>k <Esc>'<,'>:m '<-2<CR>gv=gv
"
" One
" Two
" Three
" Four
" Five
" Six
" Seven
" Eight
" Nine
" Ten
"
