" self installation of plug TODO: don't do this on windows!
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugs
call plug#begin('~/.config/nvim')

Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }

Plug 'itchyny/lightline.vim'
Plug 'Raimondi/delimitMate'
Plug 'keith/swift.vim'
Plug 'pangloss/vim-javascript'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/goyo.vim'
Plug 'sheerun/vim-polyglot'

Plug 'dense-analysis/ale'
Plug 'maximbaz/lightline-ale'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'

call plug#end()

" Dont log viminfo
set viminfo=

" neovide gui things
set guifont=Cascadia\ Code:h16
let g:neovide_remember_window_size = v:true

" setup colorscheme
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

colorscheme spaceduck
highlight Comment guifg=#686f9a ctermfg=60 gui=italic cterm=italic
highlight Todo guibg=#0f111b ctermbg=233 gui=bold,italic cterm=bold,italic
highlight Conditional gui=italic cterm=italic
highlight Repeat gui=italic cterm=italic
highlight Statement gui=bold,italic cterm=bold,italic
highlight Operator gui=bold cterm=bold
highlight pythonOperator gui=bold cterm=bold

" lightline stuff
" maybe fix reee
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = { 'colorscheme': 'spaceduck'}

" lightline-ale things
let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.active = { 'right': [['lineinfo', 'percent'],
						\			[ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
						\			[ 'fileformat', 'fileencoding', 'filetype' ]] }

" set some stuff?
syntax on
syntax enable

" tabs are 4 columns wide
set shiftwidth=4
set tabstop=4

" regular line numbers
set number

" set no line wrapping
set nowrap

" set mouse to be able to be used
set mouse=a

" set assembly to use nasm formatting
au BufRead,BufNewFile *.asm  set ft=nasm

" lightline stuff
set laststatus=2
set noshowmode
set showcmd

" make backspace act normally
set backspace=indent,eol,start

" use system clipboard
set clipboard+=unnamedplus

" don't show startscreen, just edit new file when vim is opened
set shm+=I

" use <Esc> to clear search highlighting
nmap <silent> <Esc> :noh<CR>

" NeoVim specific stuff
if has("nvim")
	" use <Esc> to exit terminal-mode
	tnoremap <Esc> <C-\><C-n>
   	" don't show linenumbers in :terminal mode
   	autocmd TermOpen * setlocal nonumber norelativenumber
endif

" use [shift]-tab to cycle through tabs
nnoremap <silent> <Tab> :tabnext<CR>
nnoremap <silent> <S-Tab> :tabprevious<CR>

" Recursively search for files in subdirs
set path+=**

"disable ex mode
map Q <Nop>

" netrw - remove banner and show project tree
let g:netrw_banner=0
let g:netrw_liststyle=3

" delimitMate + indentation options
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
set smartindent

" remove trailing whitespace (except on markdown files)
function StripTrailingWhitespace()
	if &ft != "markdown"
		%s/\s\+$//e
	endif
endfunction
autocmd BufWritePre * silent call StripTrailingWhitespace()

" disable highlighting in vim-sneak, and use s for operators
" highlight link Sneak Normal
omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

" ncm2 stuff
augroup NCM2
	autocmd!
	" enable ncm for all buffers
	autocmd BufEnter * call ncm2#enable_for_buffer()

	" :help Ncm2PopupOpen for more info. Idk what this does.
	set completeopt=noinsert,menuone,noselect
augroup END
let ncm2#popup_delay = 5
" let ncm2#complete_length = [[1,1]]
let g:ncm2#matcher = 'substrfuzzy'
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set shortmess+=c

" ALE settings
let g:ale_sign_column_always = 1
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_linters = {'python': ['flake8']}
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 200
" ALE flake8 settings
let g:ale_python_flake8_options = '--ignore=E501,E261,E262'

" settings for Goyo
let g:goyo_width = 90
let g:goyo_height = 90
" remap <F4> to Goyo with good sizing
noremap <F4> :Goyo 100%x100%<CR>

" Disable automatic comment insertion
autocmd FileType * silent
setlocal formatoptions-=c formatoptions-=r formatoptions-=o
