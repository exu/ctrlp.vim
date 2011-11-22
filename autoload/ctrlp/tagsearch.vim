" =============================================================================
" File:          autoload/ctrlp/tagsearch.vim
" Description:   Simple tagsearch extension
" Author:        Jacek Wysocki <jacek.wysocki@gmail.com>
" =============================================================================
"
" To load this extension into ctrlp, add this to your vimrc:
"
"     let g:ctrlp_extensions = ['tagsearch']
"
" 'tagsearch' is the name of the file 'tagsearch.vim'
"
" For multiple extensions:
"
"     let g:ctrlp_extensions = [
"         \ 'my_extension',
"         \ 'my_other_extension',
"         \ 'tagsearch',
"         \ ]


" Change the name of the g:loaded_ variable to make it unique
if ( exists('g:loaded_ctrlp_tagsearch') && g:loaded_ctrlp_tagsearch )
	\ || v:version < 700 || &cp
	fini
endif
let g:loaded_ctrlp_tagsearch = 1


" The main variable for this extension.
"
" The values are:
" + the name of the input function (including the brackets and any argument)
" + the name of the action function (only the name)
" + the long and short names to use for the statusline
let s:tagsearch_var = [
	\ 'ctrlp#tagsearch#init()',
	\ 'ctrlp#tagsearch#accept',
	\ 'search in tags',
	\ 'tags',
	\ ]


" Append s:tagsearch_var to g:ctrlp_ext_vars
if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
	let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:tagsearch_var)
else
	let g:ctrlp_ext_vars = [s:tagsearch_var]
endif


" Provide a list of strings to search in
"
" Return: a Vim's List
func! ctrlp#tagsearch#init()
  let out = [
        \'Abrakadarbra',
        \ ]

  for tg in taglist('^.*$')
    call add(out, tg.name)
  endfor

  retu out
endfunc


" The action to perform on the selected string.
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
func! ctrlp#tagsearch#accept(mode, str)
	" For this example, just exit ctrlp and run help
  execute "tag " . a:str
  " tag a:str
endfunc


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
" Allow it to be called later
func! ctrlp#tagsearch#id()
	retu s:id
endfunc


" Create a command to directly call the new search type.
"
" Put something like this in vimrc or plugin/tagsearch.vim
" com! CtrlPTagsearch cal ctrlp#init(ctrlp#tagsearch#id())


" vim:fen:fdl=0:ts=2:sw=2:sts=2
