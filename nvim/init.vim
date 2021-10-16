let mapleader=","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rsi'
Plug 'ap/vim-css-color'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'scrooloose/syntastic'
call plug#end()

set title
set go=a
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set ignorecase

" Some basics:
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set tabstop=4
set shiftwidth=0
set softtabstop=-1
set expandtab
set smarttab
set noswapfile
set incsearch
set linebreak
set scrolloff=999
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
command W w
nmap j gj
nmap k gk

" Enable autocompletion
set wildmode=longest,list,full


"Keep undo history between sessions
" set undofile
" set undodir=~/.config/nvim/undo/

" Reload vimrc
map <leader>r :source ~/.config/nvim/init.vim<CR>

" Use <Space> to save
map <Space> :w<CR>

" Easily edit vimrc
let $RTP=split(&runtimepath, ',')[0]
let $RC="$HOME/.config/nvim/init.vim"

" Goyo plugin makes text more readable when writing prose
let g:goyo_linenr = 1
map <leader>f :Goyo \| set bg=light<CR>

" Spell-check
map <leader>s :setlocal spell! spelllang=en_us<CR>

" Splits open at the bottom and right
set splitbelow splitright

" Shortcutting split navigation, saving a keypress
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Quickly use git
nmap <leader>g :G

" Use fzf to switch files
nmap <leader>p :Files<CR>

" ascii symbols for airline
let g:airline_symbols_ascii = 1

" vim-rooter to change working directory to one with .git/
let g:rooter_patterns = ['.git']

" Vimwiki
let g:vimwiki_list = [{'path': '~/Memex', 'syntax': 'markdown', 'ext': '.md', 'diary_rel_path' : ''}]
autocmd VimEnter * let g:vimwiki_syntaxlocal_vars['markdown']['Link1'] = g:vimwiki_syntaxlocal_vars['default']['Link1']
let g:zettel_link_format="[[%link]]"
autocmd BufNewFile,BufRead *.md setlocal spell! spelllang=en_us
imap <silent> [[ [[<C-x><C-f>
nmap <C-Up> <Plug>VimwikiDiaryNextDay
nmap <C-Down> <Plug>VimwikiDiaryPrevDay

"[airline] Show bottom line always, hide vim mode
set laststatus=2
set noshowmode

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>

" fzf settiongs
nmap <C-p> :Files<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %
