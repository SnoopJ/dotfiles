syntax on

" Change dir based on file
set autochdir
" When searching try to be smart about cases 
set ignorecase
set smartcase
" 7 lines to cursor
set scrolloff=7
" number labels
set number

" Tabbing
set expandtab
set tabstop=4
set shiftwidth=4

" Buffer navigation
map <C-H> :bp!
map <C-L> :bn!

" MAD-X specifics
au BufNewFile,BufRead *.mdx setf madx
au BufNewFile,BufRead *.srv set nowrap

" Courtesy of StackOverflow user jqno, with a custom toggle function
" http://stackoverflow.com/a/1676672/2881396
" Commenting blocks of code.
autocmd FileType c,cpp,java,scala,javascript let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType madx             let b:comment_leader = '! '
" weirdly, Ctrl+/ is recognized as Ctrl+_ ?
noremap <silent> <C-_> :call ToggleComment(b:comment_leader)<CR>

function! ToggleComment(commentchar) range
    let lnum = a:firstline
    let commentchar_esc = escape(a:commentchar,'\/"%>#')
    while lnum <= a:lastline
        exe "normal " . lnum . "gg"
        if match(getline(lnum), "^\W*" . commentchar_esc) > -1
            exe (":s/^\s*" . commentchar_esc . "//")
        else
            exe "normal gI" . a:commentchar
        endif
        let lnum = lnum + 1
    endwhile
    exe "normal " . a:firstline . "gg"
endfunction

"  *** VISUALS ***
execute pathogen#infect()
let g:solarized_italic=0
let g:airline#extensions#tabline#enabled = 1
" Status bar
set laststatus=2
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Scheme fixins
set t_Co=256
let g:solarized_termcolors = &t_Co
set background=dark
colorscheme solarized
let g:airline_theme='solarized'
