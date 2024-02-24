" don't load twice
if exists("g:loaded_pidgin") || &cp || v:version < 700
  finish
endif
let g:loaded_pidgin = 1

" k -> scan the files given with the 'dictionary' option
setlocal complete+=k

function! GetDictionaries()
  let paths=split(globpath(&rtp, '**/*.dictionary'))
  if (exists("g:pidgin_dir"))
    let paths+=split(glob(g:pidgin_dir.'/*.dictionary'))
  endif
  return paths
endfunction

" improve auto-completion
function! LoadSpelling()
  let paths=GetDictionaries()
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
  let paths=GetDictionaries()
  let dictionaryPath=join(paths, ',')
  execute 'setlocal dictionary+='.dictionaryPath
endfunction

" only at startup
call LoadSpelling()

" when a new buffer is entered
autocmd BufEnter * :call LoadDictionary()

command! -nargs=0 LoadSpelling call LoadSpelling()
command! -nargs=0 LoadDictionary call LoadDictionary()
