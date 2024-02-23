" pidgin.vim

" don't load twice
if exists("g:loaded_pidgin") || &cp || v:version < 700
  finish
endif
let g:loaded_pidgin = 1

" k -> scan the files given with the 'dictionary' option
setlocal complete+=k

" scan the runtimepath for files that have the `.dictionary` suffix
" and append them to the `dictionary` setting
function! LoadDictionary()
  let dictionaryPath=join(split(globpath(&rtp, '**/*.dictionary')), ',')
  execute 'setlocal dictionary+='.dictionaryPath
endfunction

function! LoadSpelling()
  let paths=split(globpath(&rtp, '**/*.dictionary'))
  for path in paths
    if path =~ "standard.dictionary"
      continue
    endif
    for word in readfile(path)
      execute "silent spellgood!" . word
    endfor
  endfor
endfunction

" when vim first starts up
call LoadSpelling()

autocmd BufEnter * :call LoadDictionary()

command! -nargs=0 LoadDictionary call LoadDictionary()
command! -nargs=0 LoadSpelling call LoadSpelling()
