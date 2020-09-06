set nocompatible              " be iMproved, required
filetype off                  " required


filetype plugin indent on
syntax on
set encoding=utf-8
" set spell 
" set spelllang=en_us
set hlsearch
set tabstop=3
set softtabstop=3
set shiftwidth=3
set expandtab
set hlsearch

set number relativenumber
" set number
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
 endfun

autocmd BufWritePre *.ino,*.h,*.c,*.java,*.cpp,*.hpp  :call <SID>StripTrailingWhitespaces()

set path+=**
set wildmenu

" OR ELSE just the 81st column of wide lines...
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" This rewires n and N to do the highlighing...
nnoremap <silent> n   n:call HLNext(0.4)<cr>
nnoremap <silent> N   N:call HLNext(0.4)<cr>

" OR ELSE just highlight the match in red...
function! _HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let ring = matchadd('WhiteOnRed', target_pat, 101)
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    redraw
endfunction

 " EITHER blink the line containing the match...
function! HLNext (blinktime)
    set invcursorline
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    set invcursorline
    redraw
endfunction

"====[ Make tabs, trailing whitespace, and non-breaking spaces visible ]======

"exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
exec "set listchars=trail:\uB7,nbsp:~"
set list

command! MakeTags !ctags -R .
" Use ^] to jump to tag
" Use ^t to jump back
" Use g^] to show all locations where tags exist
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'

Plugin 'itchyny/lightline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'frazrepo/vim-rainbow'
"Plugin 'jiangmiao/auto-pairs'
"Plugin 'Chiel92/vim-autoformat'
" Plugin 'preservim/nerdcommenter'
" Plugin 'ctrlpvim/ctrlp.vim'
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'morhetz/gruvbox'
" Plugin 'mileszs/ack.vim'
Plugin 'tpope/vim-surround'
" Plugin 'majutsushi/tagbar'
Plugin 'ervandew/supertab'
Plugin 'pangloss/vim-javascript'


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
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

"
" map <C-o> :NERDTreeToggle %<CR>
" let NERDTreeShowHidden=1

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_java_checkers = []
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_key_list_stop_completion = [ '<C-y>', '<CR>' ]

" let g:rainbow_active = 1

" update vim-gutter to 100ms
set updatetime=500

" set :Autoformat command to <F3>
noremap <F3> :Autoformat<CR>

nmap <F8> :TagbarToggle<CR>

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-l> <C-w>l
nmap <C-k> <C-w>k
"
set timeoutlen=1000
" Map tab to go to next window when split
" map <M-Tab> <C-W>w

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


let g:gruvbox_contrast_dark="hard"
autocmd vimenter * colorscheme gruvbox 
set background=dark    " Setting dark mode

" -----
" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

set wildignore+=*/tmp/*,*.so,*.swp,*.class,*.zip     " MacOSX/Linux

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nnoremap <Leader>ff :Files!<CR>
nnoremap <Leader>fg :GFiles!<CR>
nnoremap <Leader>fb :Buffers<CR>
nnoremap <Leader><Enter> :silent! nohls<cr>
"
nnoremap <esc><esc> :silent! nohls<cr>

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

"
" Make sure that ultisnips and you complete me does not interect
"
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_key_list_stop_completion = [ '<C-y>', '<CR>' ]

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

nnoremap <Leader>gf :execute "%! grep -A 4 -- " . shellescape(@/) ." %"<CR>


function! RunLineCmd ()
    "let [bufnum, lnum, col, off] = getpos('.')
    let prev  = getpos('.')
    let cmd = getline('.')
    execute ("r !" . cmd)
    call setpos ('.', prev)
    execute ("normal! dd")
endfunction

function! EvalVimScriptLine ()
    "let [bufnum, lnum, col, off] = getpos('.')
    let prev  = getpos('.')
    let cmd = getline('.')
    execute "normal! A" . execute ("echo (" . cmd .")" ) . "\<esc>"
    call setpos ('.', prev)
    execute ("normal! dd")
endfunction

nnoremap <Leader>x :call RunLineCmd()<CR>
nnoremap <Leader>e :call EvalVimScriptLine()<CR>

function! PotionShowBytecode()
    " Get the bytecode.
    let bytecode = system(g:potion_command . " -c -V " . bufname("%") . " 2>&1")

    " Open a new split and set it up.
    vsplit __Potion_Bytecode__
    normal! ggdG
    setlocal filetype=potionbytecode
    setlocal buftype=nofile

    " Insert the bytecode.
    call append(0, split(bytecode, '\v\n'))
endfunction


set completeopt=menu,preview
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
