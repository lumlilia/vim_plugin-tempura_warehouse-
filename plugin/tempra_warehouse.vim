if exists('g:tempura_warehouse')
  finish
endif
let g:tempura_warehouse = 1

command! -nargs=+ ImportTemplate call tempura_warehouse#ImportTemplate(<f-args>)
command! -nargs=1 ExportTemplate call tempura_warehouse#ExportTemplate(<f-args>)
command! -nargs=+ ImTpl call tempura_warehouse#ImportTemplate(<f-args>)
command! -nargs=1 ExTpl call tempura_warehouse#ExportTemplate(<f-args>)

aug auto_load_template
  au!
  au BufNewFile * call tempura_warehouse#AutoLoadTemplate(expand('%:e'))
aug END
