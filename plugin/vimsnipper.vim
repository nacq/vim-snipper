"=============================================================================
" vimsnipper.vim
" Author: Nicolas Acquaviva <nicolaseacquaviva@gmail.com>
"=============================================================================

function! GetCursorLine()
  let cursor_pos = getpos(".")

  return cursor_pos[1]
endfunction

function! ReadJson()
  try
    let json_file = readfile(g:snippets_file)
  catch /.*/
    echo "vimsnipper Error: Error opening snippets file"
    return {}
  endtry
  try
    " vim8 and neovim support this function
    let json = json_decode(json_file)
  catch /.*/
    echo "vimsnipper Error: Error decoding json file"
    return {}
  endtry

  return json
endfunction

function! Print(element_to_print)
  let json = ReadJson()

  for element in reverse(json[a:element_to_print])
    call appendbufline(bufname(), GetCursorLine(), element)
  endfor
endfunction

function! GenerateCommands()
  let json = ReadJson()

  for key in keys(json)
    let command_name = "VS" . key
    execute "command! " . command_name . " :call Print(" . string(key) . ")"
  endfor
endfunction

if !exists('g:vim_snipper_loaded')
  let g:vim_snipper_loaded = 1

  call GenerateCommands()
endif

