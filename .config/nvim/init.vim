" Pastemode
" Easy motion <space>h
" Surround
" Go to file end - G

"----------------------------------------------
" Install vim plug if not present
"----------------------------------------------
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


"----------------------------------------------
" Install plugins
"----------------------------------------------
call plug#begin()

" General plugins
Plug 'airblade/vim-rooter' " changes root to first parent .git dir
Plug 'vim-airline/vim-airline'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/fzf', { 'dir': '~/.config/nvim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'vimwiki/vimwiki'
Plug 'w0rp/ale'

" Colors
Plug 'tomasr/molokai'

" Language support
Plug 'aklt/plantuml-syntax'
Plug 'fatih/vim-go'
Plug 'hashivim/vim-terraform'
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
Plug 'LnL7/vim-nix'
Plug 'OmniSharp/omnisharp-vim'
call plug#end()

"----------------------------------------------
" General settings
"----------------------------------------------
filetype plugin indent on

set autoindent                    " take indent for new line from previous line
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
"set clipboard=unnamedplus
set colorcolumn=81                " highlight the 80th column as an indicator
set completeopt-=preview          " remove the horrendous preview window
set cursorline                    " highlight the current line for the cursor
set encoding=utf-8
set eol
set noexpandtab                   " expands tabs to spaces
set foldnestmax=1
set list                          " show trailing whitespace
set listchars=tab:\ \ ,trail:▫
set nospell                       " disable spelling
set noswapfile                    " disable swapfile usage
set nowrap
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!
set number                      " show number ruler
set formatoptions=tcqron          " set vims text formatting options
set smartindent                   " enable smart indentation
set shiftwidth=2
set softtabstop=2
set tabstop=2
set textwidth=0
set updatetime=1000                " redraw the status bar often
set undofile
set undodir=~/.config/nvim/undodir
set wrapmargin=0

" Allow vim to set a custom font or color for a word
syntax enable

" Set the leader button
let mapleader = ' '

" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" Center the screen quickly
nnoremap <space> zz

"----------------------------------------------
" Colors
"----------------------------------------------
colorscheme molokai

"----------------------------------------------
" Searching
"----------------------------------------------
set incsearch                     " move to match as you type the search query
set hlsearch                      " disable search result highlighting

if has('nvim')
	set inccommand=split          " enables interactive search and replace
endif

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"----------------------------------------------
" Navigation
"----------------------------------------------
" Disable arrow keys
"noremap <Up> <NOP>
"noremap <Down> <NOP>
"noremap <Left> <NOP>
"noremap <Right> <NOP>

" Move between buffers with Shift + arrow key...
"nnoremap <S-Left> :bprevious<cr>
"nnoremap <S-Right> :bnext<cr>

" ... but skip the quickfix when navigating
augroup qf
	autocmd!
	autocmd FileType qf set nobuflisted
augroup END

" Fix some common typos
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Vsp vsp
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"----------------------------------------------
" Splits
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

"----------------------------------------------
" Plugin: hashivim/vim-terraform
"----------------------------------------------
" Allow plugin to manage indent
let g:terraform_align=1

" Allow plugin to auto fold
let g:terraform_fold_sections=1

let g:terraform_fmt_on_save=1

"----------------------------------------------
" Plugin: airblade/vim-rooter
"----------------------------------------------
let g:rooter_change_directory_for_non_project_files = 'current'
let g:rooter_targets = '.git/,*.yml,*.yaml,Dockerfile'

"----------------------------------------------
" Plugin: vim-airline/vim-airline
"----------------------------------------------
" Show status bar by default.
set laststatus=2

" Enable top tabline.
let g:airline#extensions#tabline#enabled = 1

" Disable showing tabs in the tabline. This will ensure that the buffers are
" what is shown in the tabline at all times.
let g:airline#extensions#tabline#show_tabs = 0

" Enable powerline fonts.
let g:airline_powerline_fonts = 0

"----------------------------------------------
" Plugin: vimwiki/vimwiki
"----------------------------------------------
" Path to wiki
let g:vimwiki_list = [{
			\ 'path': '~/Dropbox/vimwiki',
			\ 'syntax': 'markdown',
			\ 'ext': '.vimwiki.markdown'}]

au FileType vimwiki set expandtab
au FileType vimwiki set shiftwidth=2
au FileType vimwiki set softtabstop=2
au FileType vimwiki set tabstop=2


"----------------------------------------------
" Plugin: 'OmniSharp'
"----------------------------------------------
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_server_use_mono = 1

"----------------------------------------------
" Plugin: 'w0rp/ale'
"----------------------------------------------

let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_dockerfile_hadolint_use_docker = 1

let g:ale_linters = {
		  \   'cs': ['OmniSharp'],
			\   'go': ['gometalinter'],
			\   'javascript': ['prettier', 'eslint'],
			\}

" In ~/.vim/vimrc, or somewhere similar.
let g:ale_fixers = {
			\   '*': ['remove_trailing_lines', 'trim_whitespace'],
			\   'javascript': ['prettier', 'eslint'],
			\}

let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
hi link ALEErrorSign    Error
hi link ALEWarningSign  Warning


"----------------------------------------------
" General Shortcuts
"----------------------------------------------

" leader f  - reformat based on tab/space prefs
"nmap <leader>f gg=G''<cr>
nmap <leader>f mzgg=G`z

" Fold file
nmap <leader>fo zo<cr>
nmap <leader>fc zc<cr>
nmap <leader>fac :setlocal foldmethod=syntax<cr>
nmap <leader>fao :setlocal foldmethod=manual<cr>:e<cr>

" leader s - save
nmap <leader>s :w<cr>

" Leader o - open file picker
nnoremap <leader>o :FZF<cr>

" Quickly open/reload vim
nnoremap <leader>vvim :vsp $MYVIMRC<CR>
nnoremap <leader>svim :source $MYVIMRC<CR>

" Move
map  <leader>h <Plug>(easymotion-bd-w)
nmap <leader>h <Plug>(easymotion-overwin-w)

" Clear search highlights
map <leader>c :nohlsearch<crvm>

"----------------------------------------------
" Language: Golang
"----------------------------------------------
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

au BufNewFile,BufRead *.gotemplate set filetype=gotemplate
au FileType gotemplate set noexpandtab
au FileType gotemplate set shiftwidth=4
au FileType gotemplate set softtabstop=4
au FileType gotemplate set tabstop=4

" Mappings
au FileType go nmap <leader>f :w<cr>

au FileType go nmap <leader>e :GoErrCheck<cr>

au FileType go nmap <leader>tc :GoCoverageToggle -short<cr>
au FileType go nmap <leader>tt :GoTest -short<cr>
au FileType go nmap <leader>tl :GoTest -race<cr>
au FileType go nmap <leader>tf :GoTestFunc

au FileType go nmap <leader>gd <Plug>(go-def)
au FileType go nmap <leader>gdp <Plug>(go-def-pop)
au FileType go nmap <leader>gdv <Plug>(go-def-vertical)
au FileType go nmap <leader>gdh <Plug>(go-def-horizontal)

au FileType go nmap <leader>gD <Plug>(go-doc)
au FileType go nmap <leader>gDv <Plug>(go-doc-vertical)

au FileType go nmap <leader>gm :GoDeclsDir<cr>

"au Filetype go nmap <leader>ga <Plug>(go-alternate-edit)
"au Filetype go nmap <leader>gah <Plug>(go-alternate-split)
"au Filetype go nmap <leader>gav <Plug>(go-alternate-vertical)


" Run goimports when running gofmt
let g:go_fmt_command = "goimports"

" Enable syntax highlighting per default
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1

" Show the progress when running :GoCoverage
let g:go_echo_command_info = 1

" Show type information
let g:go_auto_type_info = 1

" Highlight variable uses
let g:go_auto_sameids = 1

" Fix for location list when vim-go is used together with Syntastic
let g:go_list_type = "quickfix"

" Set whether the JSON tags should be snakecase or camelcase.
let g:go_addtags_transform = "camelcase"

" Open godef in vertical tab
let g:godef_split=3

" Open godef same file in same window
let g:godef_same_file_in_same_window=1

let g:go_test_timeout = '4s'

let g:ale_go_gometalinter_options = '--fast'

"----------------------------------------------
" Language: Bash
"----------------------------------------------
au FileType sh set noexpandtab
au FileType sh set shiftwidth=2
au FileType sh set softtabstop=2
au FileType sh set tabstop=2

"----------------------------------------------
" Language: C#
"----------------------------------------------
au FileType cs set expandtab
au FileType cs set shiftwidth=4
au FileType cs set softtabstop=4
au FileType cs set tabstop=4

"----------------------------------------------
" Language: Docker
"----------------------------------------------
au FileType Dockerfile set expandtab
au FileType Dockerfile set shiftwidth=2
au FileType Dockerfile set softtabstop=2
au FileType Dockerfile set tabstop=2

autocmd FileType Dockerfile let b:comment_leader = '# '


"----------------------------------------------
" Language: gitcommit
"----------------------------------------------
au FileType gitcommit setlocal spell
au FileType gitcommit setlocal textwidth=80

"----------------------------------------------
" Language: gitconfig
"----------------------------------------------
au FileType gitconfig set noexpandtab
au FileType gitconfig set shiftwidth=2
au FileType gitconfig set softtabstop=2
au FileType gitconfig set tabstop=2

"----------------------------------------------
" Language: HTML
"----------------------------------------------
au FileType html set expandtab
au FileType html set shiftwidth=2
au FileType html set softtabstop=2
au FileType html set tabstop=2

"----------------------------------------------
" Language: JavaScript
"----------------------------------------------
au FileType javascript set expandtab
au FileType javascript set shiftwidth=2
au FileType javascript set softtabstop=2
au FileType javascript set tabstop=2

"----------------------------------------------
" Language: JSON
"----------------------------------------------
au FileType js set expandtab
au FileType js set shiftwidth=2
au FileType js set softtabstop=2
au FileType js set tabstop=2

"----------------------------------------------
" Language: JSON
"----------------------------------------------
au FileType json set expandtab
au FileType json set shiftwidth=2
au FileType json set softtabstop=2
au FileType json set tabstop=2

"----------------------------------------------
" Language: Make
"----------------------------------------------
au FileType make set noexpandtab
au FileType make set shiftwidth=2
au FileType make set softtabstop=2
au FileType make set tabstop=2

"----------------------------------------------
" Language: Markdown
"----------------------------------------------
au FileType markdown setlocal spell
au FileType markdown set expandtab
au FileType markdown set shiftwidth=2
au FileType markdown set softtabstop=2
au FileType markdown set tabstop=2

"----------------------------------------------
" Language: PlantUML
"----------------------------------------------
au FileType plantuml set expandtab
au FileType plantuml set shiftwidth=2
au FileType plantuml set softtabstop=2
au FileType plantuml set tabstop=2

"----------------------------------------------
" Language: Protobuf
"----------------------------------------------
au FileType proto set expandtab
au FileType proto set shiftwidth=2
au FileType proto set softtabstop=2
au FileType proto set tabstop=2

"----------------------------------------------
" Language: Python
"----------------------------------------------
au FileType python set expandtab
au FileType python set shiftwidth=4
au FileType python set softtabstop=4
au FileType python set tabstop=4

"----------------------------------------------
" Language: Ruby
"----------------------------------------------
au FileType ruby set expandtab
au FileType ruby set shiftwidth=2
au FileType ruby set softtabstop=2
au FileType ruby set tabstop=2

"----------------------------------------------
" Language: YAML
"----------------------------------------------
au FileType yaml set expandtab
au FileType yaml set shiftwidth=2
au FileType yaml set softtabstop=2
au FileType yaml set tabstop=2

" Other settings?
highlight ColorColumn ctermbg=black guibg=black
highlight SignColumn ctermbg=black guibg=black
