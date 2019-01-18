" dictionary.vim - include custom words in Vim's auto-complete

" don't load twice
if exists("g:loaded_dictionary") || &cp || v:version < 700
  finish
endif
let g:loaded_dictionary = 1

" k -> scan the files given with the 'dictionary' option
setlocal complete+=k

" scan the runtimepath for files that have the `.dictionary` suffix
" and append them to the `dictionary` setting
function! LoadDictionary()
  let dictionaryPath=join(split(globpath(&rtp, '**/*.dictionary')), ',')
  execute 'setlocal dictionary+='.dictionaryPath
endfunction

autocmd BufEnter * :call LoadDictionary()
