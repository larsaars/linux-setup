" AUTHOR: larsaars
" REPOSITORY: https://github.com/larsaars/linux-setup


"+++++++++++++++++++++++++++++++++ Load Plugins +++++++++++++++++++++++++++++++++"

" load vim-plug plugin
call plug#begin('~/.vim/plugged')

" plugins
Plug 'itchyny/lightline.vim'
Plug 'ap/vim-css-color'
Plug 'dense-analysis/ale'
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
highlight LineNr ctermbg=black
set colorcolumn=80
highlight ColorColumn ctermbg=234

" function to switch theme between light and dark
let g:LightTheme = 0
function! ChangeTheme()
    if g:LightTheme
        let g:LightTheme = 0
        colorscheme codedark
        set background=dark
        highlight Normal ctermbg=black
        highlight EndOfBuffer ctermbg=black
        highlight colorcolumn ctermbg=234
        highlight LineNr ctermbg=black
    else 
        let g:LightTheme = 1
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
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
nnoremap <M-j> :tabp<CR>
nnoremap <M-k> :tabn<CR>

" leaving easier by pressing j and k at the same time
inoremap jk <esc>
inoremap kj <esc>

" fix pasting from other application with f2
set pastetoggle=<F2>
" git commands (pull, add | commit, push)
map <F3> :!git pull <CR>
map <F4> :!git add -A && git commit -m "
map <F5> :!git push <CR>
" autoformat code on pressing f6 for any language
map <F6> :!cp ~/.clang-format %:h <CR> :w <CR> :call FormatButton() <CR> 
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
map ä A<space>{<CR><CR><esc><<<<<<ki<tab>

" add semicolon at end of line
map ö A;<esc>
