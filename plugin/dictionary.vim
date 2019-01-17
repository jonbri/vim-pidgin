" dictionary.vim - include custom words in Vim's auto-complete

" don't load twice
if exists("g:loaded_dictionary") || &cp || v:version < 700
  finish
endif
let g:loaded_dictionary = 1

let s:dictionaryPath=fnamemodify(resolve(expand('<sfile>:p:h')), ':h').'/words.txt'

setlocal complete+=k

function! LoadDictionary()
  execute 'setlocal dictionary+='.s:dictionaryPath
endfunction

autocmd BufEnter * :call LoadDictionary()
