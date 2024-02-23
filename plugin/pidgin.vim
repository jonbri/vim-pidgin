" pidgin.vim

" don't load twice
if exists("g:loaded_pidgin") || &cp || v:version < 700
  finish
endif
let g:loaded_pidgin = 1

" k -> scan the files given with the 'dictionary' option
setlocal complete+=k

" improve auto-completion
function! LoadSpelling()
  let paths=split(globpath(&rtp, '**/*.dictionary'))
  for path in paths
    " use the built-in dictionary for standard words
    if path =~ "standard.dictionary"
      continue
    endif
    for word in readfile(path)
      execute "silent spellgood!" . word
    endfor
  endfor
endfunction

" improve spell checking
function! LoadDictionary()
  let paths=split(globpath(&rtp, '**/*.dictionary'))
  let dictionaryPath=join(paths, ',')
  execute 'setlocal dictionary+='.dictionaryPath
endfunction

" only at startup
call LoadSpelling()

" when a new buffer is entered
autocmd BufEnter * :call LoadDictionary()

command! -nargs=0 LoadSpelling call LoadSpelling()
command! -nargs=0 LoadDictionary call LoadDictionary()
