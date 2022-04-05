" AUTHOR: larsaars
" REPOSITORY: https://github.com/larsaars/linux-setup


"+++++++++++++++++++++++++++++++++ Load Plugins +++++++++++++++++++++++++++++++++"

" load vim-plug plugin
call plug#begin('~/.vim/plugged')

" plugins
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
Plug 'KarimElghamry/vim-auto-comment'
call plug#end()


"++++++++++++++++++++++++++++++++ Appearance +++++++++++++++++++++++++++++++++"

" syntax highlighting
syntax on
" display line numbers 
set number
" show a visual line under the cursors current line
set cursorline

" lightline settings
set laststatus=2
let g:lightline = {
            \ 'colorscheme': 'PaperColor'
            \ }

" colorscheme and styling options
colorscheme codedark 
set background=dark
highlight Normal ctermbg=black
highlight EndOfBuffer ctermbg=black
highlight colorcolumn ctermbg=234
highlight LineNr ctermbg=black

" function to switch theme between light and dark
let g:ThemeN = 2
function! ChangeTheme()
    if g:ThemeN == 1
        let g:ThemeN = 2
        colorscheme codedark 
        set background=dark
        highlight Normal ctermbg=black
        highlight EndOfBuffer ctermbg=black
        highlight colorcolumn ctermbg=234
        highlight LineNr ctermbg=black
    elseif g:ThemeN == 2
        let g:ThemeN = 3
        colorscheme jummidark
    else
        let g:ThemeN = 1
        colorscheme PaperColor 
        set background=light
        highlight colorcolumn ctermbg=lightgray
    endif
endfunction


"+++++++++++++++++++++++++++++++++ Behaviour +++++++++++++++++++++++++++++++++"

" autoread files if reloaded (by versioncontrol for example)
set autoread
" enable autoindent
filetype indent plugin on
" set default indentation
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab


" auto close brackets and quotes
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>

" Skipping over closing brackets and quotes
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> "  strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : "\"\"\<Left>"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "\'" ? "\<Right>" : "\'\'\<Left>"

" when brace + enter is pressed automatically add indent correctly and add
" missing brace
inoremap {<CR> {<CR>}<Esc>ko
inoremap [<CR> [<CR>]<Esc>ko
inoremap (<CR> (<CR>)<Esc>ko

" Other
set nowb
set showcmd
set hlsearch
set nobackup
set incsearch
set smartcase
set noswapfile
set smartindent
set noerrorbells
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" vim auto comment variables
let g:default_inline_comment="#"
let g:inline_comment_dict = {
		\'//': ["js", "ts", "cpp", "c", "dart"],
		\'#': ['py', 'sh'],
		\'"': ['vim', 'vimrc'],
		\}

" function to beautify file automatically on write
function FormatBuffer()
    if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
        let cursor_pos = getpos('.')
        :%!clang-format
        call setpos('.', cursor_pos)
    endif
endfunction

autocmd BufWritePre *.h,*.hpp,*.c,*.cpp,*.vert,*.frag,*.java :call FormatBuffer() 

" format on f6 click by keeping pointer and just calling gg=G
function FormatButton()
    if &modified && !empty(findfile('.clang-format', expand('%:p:h') . ';'))
        let cursor_pos = getpos('.')
        gg=G
        call setpos('.', cursor_pos)
    endif
endfunction



" every c and cpp (and other languages) file will be formatted by the program clang-format
" (installed)
autocmd FileType c,cpp,java,cs setlocal equalprg=clang-format

" ale linter options
let g:ale_fix_on_save=1

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
let b:ale_warn_about_trailing_whitespace = 0


" file specified auto commands
au BufRead *.pdf sil exe "!xdg-open " . shellescape(expand("%:p")) | bd | let &ft=&ft | redraw!


"+++++++++++++++++++++++++++++++++ Netrw (file menu) +++++++++++++++++++++++++++++++++"
" appearance
let g:netrw_liststyle = 3 
let g:netrw_banner = 0
let g:netrw_browse_split = 0
let g:netrw_winsize = 25
" start netrw silent
let g:netrw_silent = 1
" when pressing v open in window on right of tree
let g:netrw_altv=1
" close window after opening file
let g:netrw_fastbrowse=0
" Netrw toggle function
let g:NetrwIsOpen = 0
function! ToggleNetrw()
    if g:NetrwIsOpen
        let i = bufnr("$")
        while (i >= 1)
            if (getbufvar(i, "&filetype") == "netrw")
                silent exe "bwipeout " . i 
            endif
            let i-=1
        endwhile
        let g:NetrwIsOpen=0
    else
        let g:NetrwIsOpen=1
        silent Lexplore
    endif
endfunction


"+++++++++++++++++++++++++++++++++ Key Bindings +++++++++++++++++++++++++++++++++"

" Change tab bindings (alt+j/alt+k)
" and set M-l to save file
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
execute "set <M-l>=\el"

nnoremap <M-j> :tabp<CR>
nnoremap <M-k> :tabn<CR>
nnoremap <M-l> :w <CR>

" leaving easier by pressing j and k at the same time
inoremap jk <esc>
inoremap kj <esc>

" fix pasting from other application with f2
set pastetoggle=<F2>
" git commands (pull, add | commit, push)
map <F3> :!git pull <CR>
map <F4> :!git add -A && git commit -m "
map <F5> :!git push <CR>
" copy with .clang-format to current dir of file on pressing f6
map <F6> !cp ~/.clang-format "%:h" <CR>
" compile with compile program
map <F7> :w <CR> :!~/executevim "%:p" <CR>
" press f8 to switch theme (with previously defined function)
map <F8> :call ChangeTheme()<CR>
" toggle tree on f9 or on shift+2 (which is basically ")
map <F9> :call ToggleNetrw() <CR>
map " :call ToggleNetrw() <CR>
" quit with override on pressing f10
map <F10> :q!<CR>

" easier parenthesis opening
map ä A<space>{<CR>
" add semicolon at end of line
map ö A;<esc>
" easier deletion of two belonging parenthesis
map ü mp%x`px

" keys for auto commenting:
" auto inline comment in command and in visual mode
nnoremap + :AutoInlineComment <CR>
vnoremap + :AutoInlineComment <CR>
 
" remap minus in command mode to put a newline below
noremap - mpo<esc>`p

