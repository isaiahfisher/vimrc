set termguicolors
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

Plug 'w0rp/ale'

Plug 'Omnisharp/omnisharp-vim'

Plug 'tpope/vim-dispatch'

Plug 'RRethy/vim-illuminate'

call plug#end()
"buffer becomes hidden when focus is lost
set hid
"This group handles all omnisharp stuffs
"===========================================================================================================
let g:OmniSharp_start_without_solution=1
let g:OmniSharp_server_stdio=1
let g:ale_linters = { 'cs': ['OmniSharp'] }

" Update symantic highlighting on BufEnter and InsertLeave
let g:OmniSharp_highlight_types = 2
set completeopt=longest,menuone,preview
set previewheight=5
let g:OmniSharp_timeout = 5
augroup omnisharp_commands
    autocmd!

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>

    " Find all code errors/warnings for the current solution and populate the quickfix window
    autocmd FileType cs nnoremap <buffer> <Leader>cc :OmniSharpGlobalCodeCheck<CR>
augroup END
"===========================================================================================================
"for regex
set magic
"This line sets my background dark
set background=dark
"This line changes the theme of my editor.
colorscheme darkshire
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
"this group changes the colorscheme depending on the filetype
"this line creates a new variable to hold my original colorscheme
autocmd BufNewFile,BufRead *.* let g:tmpcolor=g:colors_name

"these line changes the colorscheme to the desired one for that filetype.
autocmd BufEnter *.cs colorscheme relaxedGreen
autocmd BufEnter *.txt colorscheme defaultme | set ft=text
autocmd BufEnter *.bat colorscheme relaxedGreen
autocmd BufEnter *.JSON colorscheme relaxedGreen | set ft=JSON
autocmd BufEnter *.xml colorscheme relaxedGreen | set ft=xml
autocmd BufEnter *.cshtml colorscheme relaxedGreen | set ft=html
autocmd BufEnter *.html colorscheme darkshire | set ft=html
autocmd BufEnter *.css colorscheme relaxedGreen | set ft=css
autocmd BufEnter *.ejs colorscheme darkshire | set ft=ejs
autocmd BufEnter _vimrc colorscheme sv
"these line returns the colorscheme to the original colorscheme when
"exiting the buffer with the changed colorscheme.
autocmd BufLeave *.cs exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.txt exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.bat exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.JSON exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.xml exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.cshtml exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.html exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.css exe 'colorscheme '.g:tmpcolor
autocmd BufLeave *.ejs exe 'colorscheme '.g:tmpcolor
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
set diffexpr=
