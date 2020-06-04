" self installation of plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugs
call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'pseudonymPatel/tomorrow-theme', {'rtp': 'vim/'}
Plug 'itchyny/lightline.vim'
Plug 'Raimondi/delimitMate'
Plug 'keith/swift.vim'
Plug 'pangloss/vim-javascript'
Plug 'justinmk/vim-sneak'
Plug 'junegunn/goyo.vim'

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

" more colorsheme stuff
"onedark.vim override: Set a custom background color in the terminal
if (has("autocmd") && !has("gui_running"))
  augroup colors
    autocmd!
    let s:background = { "gui": "#00121212", "cterm": "236", "cterm16": "0" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "bg": s:background }) "No `fg` setting
  augroup END
endif

" lightline stuff
" maybe fix reee
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = { 'colorscheme': 'onedark'}

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

" Do cool color switch thing:
function! UpdateColors()
    " Detect using an env variable
    let cmd = 'echo $IS_DARKMODE'
    " On macOS we can do something a bit more fancy
    "if IsMac()
    let cmd = 'defaults read -g AppleInterfaceStyle'
    "endif
    let dark_mode = substitute(system(cmd), '\n', '', 'g')
    " Set colorscheme and background based on mode
    if dark_mode ==# 'Dark'
		colorscheme onedark
        " set background=dark
        " call s:maybe_set_color(s:env_color_dark)
	else
        colorscheme Tomorrow
		" set background=light
        " call s:maybe_set_color(s:env_color_light)
    endif
endfunction
command! UpdateColors call UpdateColors()
" autocmd VimEnter * UpdateColors

" set truecolor for onedark
 if (empty($TMUX))
 	if (has("termguicolors"))
 		set termguicolors
	endif
 endif

" set onedark theme
syntax on
syntax enable

" tabs are 4 columns wide
set shiftwidth=4
set tabstop=4

" relative line numbers
set number

" set no line wrapping
set nowrap

" lightline stuff
set laststatus=2
set noshowmode
set showcmd

colorscheme onedark

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
highlight link Sneak Normal
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
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_linters = {'python': ['flake8']}
let g:ale_lint_on_text_changed = 'always'
let g:ale_lint_delay = 500


" settings for Goyo
let g:goyo_width = 90
let g:goyo_height = 90
" remap <F4> to Goyo with good sizing
noremap <F4> :Goyo 100%x100%<CR>

" Disable automatic comment insertion
autocmd FileType * silent
setlocal formatoptions-=c formatoptions-=r formatoptions-=o

