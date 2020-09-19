set nocompatible
"this line allows text to wrap on screen edge
set wrap
"vim-plug stuff
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

call plug#end()
"buffer becomes hidden when focus is lost
set hid
set belloff=all
set updatetime=1000
set encoding=utf-8
scriptencoding utf-8
"This group handles all gruvbox things
"===========================================================================================================
"This line sets my background dark
set background=dark
"This line changes the theme of my editor.
augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  autocmd ColorScheme * highlight Normal     ctermbg=0 guibg=#000000
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END
colorscheme gruvbox
"===========================================================================================================
"This group handles all omnisharp stuffs
"===========================================================================================================
let g:OmniSharp_start_without_solution=1
let g:OmniSharp_server_stdio=1
let g:ale_linters = { 'cs': ['OmniSharp'] }
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
"===========================================================================================================
"Lightline stuff
"===========================================================================================================
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
"===========================================================================================================
"for regex
set magic
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
"This line handles vim-OmniCompletion
inoremap <expr> <Tab> pumvisible() ? '<C-n>' : getline('.')[col('.')-2] =~# '[[:alnum:].-_#$]' ? '<C-x><C-o>' : '<Tab>'
"this group handles how vim folds code blocks.
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
"fullscreens gvim
au GUIEnter * simalt ~x
"------------------------------------------------------------
"making things a bit faster to edit the vimrc
let mapleader=","
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
"This line allows me to use the system clipboard inside of vim
set clipboard=unnamed
"This is for tagbar
nmap <leader>tb :TagbarToggle<CR>
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
"saves backups, undotrees, and swap files to local backup directory located at
"Backups
set backupdir=C:\Users\isaia\backups\\
set directory=C:\Users\isaia\backups\\
set undodir=C:\Users\isaia\backups\\
"this will allow special syntax for ip addresses.
syn match ipaddr /\(\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)\.\)\{3\}\(25\_[0-5]\|2\_[0-4]\_[0-9]\|\_[01]\?\_[0-9]\_[0-9]\?\)/
hi link ipaddr Identifier
set diffexpr=et diffexpr=
