let s:template_dir = '~/vim_template_files/'
let s:check_files = [
\   ['Makefile', 'import_Makefile'],
\ ]


function! tempura_warehouse#ImportTemplate(name, flag = 0) abort
  let file_name = ((a:name[0] == '.') ? 'template' : 'import_') . a:name
  let path = s:template_dir . ((s:template_dir[strlen(s:template_dir) - 1] == '/') ? '' : '/') . file_name
  let gl = glob(path)
  let jp_flag = stridx(execute('lan mes'), 'ja_JP') >= 0

  if gl != ''
    if split(gl, '/')[-1] == file_name
      execute (line('.') - (a:flag ? 1 : 0)) . 'read' path

    else
      echo '"' . file_name . (jp_flag ? '"が見つかりません' : '" not found')
    endif

  else
    echo '"' . file_name . (jp_flag ? '"が見つかりません' : '" not found')
  endif
endfunction


function! tempura_warehouse#ExportTemplate(name) abort
  let file_name = ((a:name[0] == '.') ? 'template' : 'import_') . a:name
  let path = s:template_dir . ((s:template_dir[strlen(s:template_dir) - 1] == '/') ? '' : '/') . file_name
  let jp_flag = stridx(execute('lan mes'), 'ja_JP') >= 0

  if glob(s:template_dir) == ''
    echo '"' . s:template_dir . (jp_flag ? '"が見つかりません' : '" not found')
    return

  elseif glob(path) != ''
    let txt = '"' . file_name . (jp_flag ? '"は既に存在します。上書きしますか？' : '" exists. Do you want to overwrite?')


    let inp = input(txt. ' (Yes: Y|y, No: other)')

    if inp != 'Y' && inp != 'y'
      return
    endif
  endif

  execute 'w!' path
endfunction


function! LoadTemplateNew(name) abort
  let tempname = s:template_dir . a:name
  if glob(tempname) != ''
    execute '0read' tempname
    execute '$delete'
    call cursor(1, 1)
  endif
endfunction


function! tempura_warehouse#AutoLoadTemplate(name) abort
  let name_sp = split(a:name, '\.')
  let load_flag = 0

  for arr in s:check_files
    if a:name == arr[0]
      if arr[1] != ''
        call LoadTemplateNew(arr[1])
      endif

      let load_flag = 1
      break
    endif
  endfor

  if load_flag == 0 && len(name_sp) > 1
    call LoadTemplateNew('template.' . name_sp[-1])
  endif
endfunction
