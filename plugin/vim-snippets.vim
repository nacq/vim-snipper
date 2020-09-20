function! GetCursorLine()
  let cursor_pos = getpos(".")

  return cursor_pos[1]
endfunction

function! ReadJson()
  let json_file = readfile('./test.json')
  " vim8 and neovim support this function
  let json = json_decode(json_file)

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

  try
    for key in keys(json)
      let command_name = "VS" . key
      execute "command! " . command_name . " :call Print(" . string(key) . ")"
    endfor
  catch error
    echo "Json error: " . error
  endtry
endfunction
