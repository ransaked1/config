set nocompatible
set backspace=indent,eol,start

syntax on
set number
set list
set mouse=a
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

set history=700

filetype plugin on
filetype indent on

set autoread

let mapleader = ","
let g:mapleader = ","

nmap <leader>w :w!<cr>

set so=7
set wildmenu
set wildignore=*.o,*~,*.pyc
set ruler
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set hlsearch
set incsearch
set lazyredraw
set magic
set showmatch
set mat=3

set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax enable

colorscheme pablo
set background=dark

if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

set encoding=utf8
set ffs=unix,dos,mac

set nobackup
set nowb
set noswapfile

set shiftwidth=4
set tabstop=4

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

map j gj
map k gk

map <silent> <leader><cr> :noh<cr>

map <leader>bd :Bclose<cr>
map <leader>ba :1,1000 bd!<cr>

autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction


