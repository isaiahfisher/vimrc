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
Plug 'scrooloose/nerdtree'
Plug 'qpkorr/vim-renamer'
Plug 'majutsushi/tagbar'
Plug 'dense-analysis/ale'
Plug 'Omnisharp/omnisharp-vim'
Plug 'tpope/vim-dispatch'
Plug 'RRethy/vim-illuminate'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'
Plug 'nickspoons/vim-sharpenup'
Plug 'tpope/vim-fugitive'
Plug 'vimoxide/vim-cinnabar'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-jdaddy'
Plug 'isaiahfisher/vim-cinnabar-defined'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'othree/yajs.vim'
Plug 'maxmellon/vim-jsx-pretty'
call plug#end()

let mapleader=","

colorscheme cinnabar-defined

"{{{Omnisharp settings
let g:OmniSharp_start_without_solution=1
let g:OmniSharp_server_stdio=1
"sets the linters for ale
set signcolumn=yes

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'

" Update symantic highlighting on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 3
let g:OmniSharp_popup_position = 'peek'
set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:off
let g:asyncomplete_auto_completeopt = 0
let g:OmniSharp_timeout = 5

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" All sharpenup mappings will begin with `<Space>os`, e.g. `,osgd` for
" :OmniSharpGotoDefinition
let g:sharpenup_map_prefix = ',os'
let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END

if has('nvim')
  let g:OmniSharp_popup_options = {
    \ 'winhl': 'Normal:NormalFloat'
    \}
else
  let g:OmniSharp_popup_options = {
    \ 'highlight': 'Normal',
    \ 'padding': [0, 0, 0, 0],
    \ 'border': [1]
    \}
endif
let g:OmniSharp_popup_mappings = {
    \ 'sigNext': '<C-n>',
    \ 'sigPrev': '<C-p>',
    \ 'pageDown': ['<C-f>', '<PageDown>'],
    \ 'pageUp': ['<C-b>', '<PageUp>']
    \}
let g:OmniSharp_highlight_groups = {
    \ 'ExcludedCode': 'NonText'
    \}
"This line handles vim-OmniCompletion
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'

"}}}
"{{{ALE Settings
let g:ale_linters = { 
            \        'cs': ['OmniSharp'],
            \        'javascript': ['eslint'],
            \        'vue': ['eslint']
            \}
"sets the fixers for ale
let g:ale_fixers = {
            \       'javascript': ['eslint'],
            \       'typescript': ['tslint', 'prettier'],
            \       'vue': ['eslint'],
            \       'scss': ['prettier'],
            \       'html': ['prettier'],
            \}
"allows ale to autofix formatting on file save
let g:ale_fix_on_save = 1

"}}}
"{{{Lightline settings
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
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

" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "
""}}}
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
" BACKUPS: uncomment and change directory to configure backups management
" set backupdir=C:\Users\isaia\backups\\
" set directory=C:\Users\isaia\backups\\
" set undodir=C:\Users\isaia\backups\\
" BACKUPS:
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
" CTAGS: replace with proper path when configuring new machine.
let g:tagbar_ctags_bin = 'C:\Users\isaia\Vim\ctags58\ctags.exe'
"this line automatically opens NERDTree on start if no file is selected.
"au vimEnter * if !argc() | NERDTree | endif
let g:NERDTreeHijackNetrw=1
"this code allows tagBar to open automatically for certain fileTyles.
au FileType cs call SetTagBar()
au FileType javascript call SetTagBar()
au FileType c call SetTagBar()
au FileType python call SetTagBar()
"function that opens tagbar
function! SetTagBar()
    :call tagbar#autoopen(0)
endfunction
"this line handles bulk file renaming
nmap <leader>f :Renamer<CR>
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
" SPLASHSCREEN: uncomment between these lines for custom splash screen.
" if argc() == 0
"  autocmd VimEnter * call Start()
" endif
" SPLASHSCREEN:
"}}}
