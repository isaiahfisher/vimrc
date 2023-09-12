"      __     __ ______ __       __ 
"     |  \   |  \      \  \     /  \
"     | ▓▓   | ▓▓\▓▓▓▓▓▓ ▓▓\   /  ▓▓
"     | ▓▓   | ▓▓ | ▓▓ | ▓▓▓\ /  ▓▓▓
"      \▓▓\ /  ▓▓ | ▓▓ | ▓▓▓▓\  ▓▓▓▓
"       \▓▓\  ▓▓  | ▓▓ | ▓▓\▓▓ ▓▓ ▓▓
"        \▓▓ ▓▓  _| ▓▓_| ▓▓ \▓▓▓| ▓▓
"         \▓▓▓  |   ▓▓ \ ▓▓  \▓ | ▓▓
"          \▓    \▓▓▓▓▓▓\▓▓      \▓▓
                               
silent! call plug#begin()
Plug 'nikvdp/ejs-syntax'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'vimwiki/vimwiki'
Plug 'zyedidia/vim-snake'
Plug 'vim-scripts/L9'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'qpkorr/vim-renamer'
Plug 'majutsushi/tagbar'
Plug 'tpope/vim-dispatch'
Plug 'RRethy/vim-illuminate'
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'
Plug 'tpope/vim-fugitive'
Plug 'vimoxide/vim-cinnabar'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-speeddating'
Plug 'isaiahfisher/vim-cinnabar-defined'
Plug 'othree/yajs.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jwalton512/vim-blade'
call plug#end()

"vim9 packages
packadd lsp

let mapleader=","

colorscheme default

"{{{LSP Settings
"intelephense php language server
call LspAddServer([#{
        \   name: 'intelephense',
        \   filetype: ['php'],
        \   path: '/usr/local/bin/intelephense',
        \   args: ['--stdio']
        \ }])

"tsserver for javascript / typescript
call LspAddServer([#{
        \   name: 'tsserver',
        \   filetype: ['javascript', 'typescript'],
        \   path: '/usr/local/bin/typescript-language-server',
        \   args: ['--stdio']
        \ }])

"vimscript language server
call LspAddServer([#{
        \   name: 'vimls',
        \   filetype: 'vim',
        \   path: '/usr/local/bin/vim-language-server',
        \   args: ['--stdio']
        \ }])

"for document highlighting in vimscript and help
let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]
"for automatic diagnostics
call LspOptionsSet(#{
        \   showDiagOnStatusLine: v:true
        \ })

"lsp function keybinds
nnoremap <leader>gd :LspGotoDefinition<CR>
nnoremap <leader>ne :LspDiag next<CR>
nnoremap <leader>pd :LspPeekDefinition<CR>
nnoremap <leader>h  :LspHover<CR>

"}}}
"{{{Lightline settings
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent']]
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
\  }
\}

"}}}
"{{{Prettier settings
"these settings set prettier to format my code
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css
"}}}
"{{{Settings
"buffer becomes hidden when focus is lost
set hid
set belloff=all
set updatetime=1000
set encoding=utf-8
scriptencoding utf-8

"for regex
set magic
set nocompatible
"this line allows text to wrap on screen edge
set wrap
"This line turns on syntax highlighting.
syntax enable
"this group makes tabs work and spacing nice
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set smarttab
set backspace=indent,eol,start
set ai "auto-indent
"show last used command in the corner
set showcmd
"highlight cursor
set cursorline
"lets autocomplete play nice
set wildmenu
"ignores compiled files
set wildignore+=*.o,*~,*.pyc
"removes needless graphical redraws
set lazyredraw
"highlight matching braces of any sort
set showmatch
"this group helps improve vim searching.
set incsearch "search as characters are entered
set hlsearch "highlights matches
"this group handles how vim folds code blocks.
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
"fullscreens gvim
au GUIEnter * simalt ~x
"This line allows me to use the system clipboard inside of vim
set clipboard=unnamed
"this group turns on line numbers and position numbers by default.
set number
set ruler
autocmd BufEnter *.txt set ft=text
autocmd BufEnter *.JSON set ft=JSON
autocmd BufEnter *.xml set ft=xml
autocmd BufEnter *.cshtml set ft=html
autocmd BufEnter *.html set ft=html
autocmd BufEnter *.css set ft=css
autocmd BufEnter *.ejs set ft=ejs
"sets vim to auto read outside edits to a file
set autoread
"enables Emmet for only HTML, css, and php filetypes
let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall
"saves backups, undos, and swaps to a special folder
set backupdir=~/.backups
set directory=~/.backups
set undodir=~/.backups
"this will allow special syntax for ip addresses.
syn match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/
hi link ipaddr Identifier
set diffexpr=
"}}}
"{{{Remaps
"making things a bit faster to edit the vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
"tabbing management tab
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext<CR>
map <leader>tg :tabprev<CR>
"Q can now be used to format current paragraph
vmap Q gq
vmap Q gqap
"preventing windows from doing windows things
silent! vunmap <C-X>
"this group allows us to ignore random wrap issues caused by vim 
"ignoring 'imaginary' lines and jumping to the next 'real' line.
nnoremap j gj
nnoremap k gk
"this line is subject to change, highlights last inserted text
nnoremap gV `[v`]
"this line makes going into command mode easier.
inoremap ii <esc>
"This is for tagbar
nmap <leader>tb :TagbarToggle<CR>
let g:tagbar_ctags_bin = "/opt/homebrew/bin/ctags"
"this code allows tagBar to open automatically for certain fileTyles.
au FileType cs call SetTagBar()
au FileType javascript call SetTagBar()
au FileType c call SetTagBar()
au FileType python call SetTagBar()
au FileType php call SetTagBar()
"function that opens tagbar
function! SetTagBar()
    :call tagbar#autoopen(0)
endfunction
"this line handles bulk file renaming
nmap <leader>f :Renamer<CR>
map <silent><leader>jd :CtrlPTag<cr><c-\>w
"}}}
"{{{Custom Splash Screen - enabled by uncommenting line 292
fun! Start()

  "Create a new unnamed buffer to display our splash screen inside of.
  enew

  " Set some options for this buffer to make sure that does not act like a
  " normal winodw.
  setlocal
    \ bufhidden=wipe
    \ buftype=nofile
    \ nobuflisted
    \ nocursorcolumn
    \ nocursorline
    \ nolist
    \ nonumber
    \ noswapfile
    \ norelativenumber

  " Place your custom splash screen or message here.
  exec ":r ~/Vim/.splashASCII.txt"

  " When we are done writing out message set the buffer to readonly.
  setlocal
    \ nomodifiable
    \ nomodified

  " Just like with the default start page, when we switch to insert mode
  " a new buffer should be opened which we can then later save.
  nnoremap <buffer><silent> e :enew<CR>
  nnoremap <buffer><silent> i :enew <bar> startinsert<CR>
  nnoremap <buffer><silent> o :enew <bar> startinsert<CR>

endfun

" The number of files in the argument list of the current window.
" If there are 0 then that means this is a new session and we want to display
" our custom splash screen.
" if argc() == 0
"   autocmd VimEnter * call Start()
" endif
"}}}
