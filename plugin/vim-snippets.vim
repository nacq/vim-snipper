function _getCursorLine()
  let cursor_pos = getpos(".")

  return cursor_pos[1]
endfunction

function _print(elementsToPrint)
  for element in reverse(a:elementsToPrint)
    :call appendbufline(bufname(), _getCursorLine(), element)
  endfor
endfunction

function RComponent()
  let component = [
    \ "import React from 'react';",
    \ "",
    \ "type Props = {};",
    \ "",
    \ "function Component({}: Props) {}",
    \ "",
    \ "export default Component;"
  \]

  :call _print(component)
endfunction
