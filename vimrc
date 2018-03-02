set encoding=utf-8
set termencoding=utf-8
set term=xterm-256color
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'toggle_comment'
Bundle 'conque-shell'
Bundle 'fatih/vim-go'
Bundle 'majutsushi/tagbar'
Bundle 'lambdalisue/vim-pyenv'
Bundle 'Valloric/YouCompleteMe'

call vundle#end()
filetype plugin indent on

syntax on

let g:airline_fugitive=1
let g:airline_powerline_fonts=1

let g:ycm_python_binary_path='python'
let g:ycm_autoclose_preview_window_after_completion=1

set lz
set number
set foldenable
set foldmethod=syntax
set foldcolumn=3
set foldlevelstart=5
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif
set cursorline
set list
set listchars=tab:»\ ,trail:·
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,cp866

set wildmenu
set clipboard=unnamed
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

set showmatch
set hlsearch
set incsearch
set smartcase
set ignorecase

set cindent
set expandtab
au FileType crontab,fstab,make set noet ts=8 sw=8
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set softtabstop=4

set backspace=indent,eol,start
set pastetoggle=<F10>
nmap <F3> :set hlsearch!<CR>

nmap <silent> <leader>o :Explore<CR>
nmap <F8> :TagbarToggle<CR>

" Commenting blocks of code
autocmd FileType c,cpp,java,scala           let b:comment_leader = '// '
autocmd FileType sh,ruby,python             let b:comment_leader = '# '
autocmd FileType conf,fstab,sshconfig       let b:comment_leader = '# '
autocmd FileType tex                        let b:comment_leader = '% '
autocmd FileType mail                       let b:comment_leader = '> '
autocmd FileType vim                        let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

