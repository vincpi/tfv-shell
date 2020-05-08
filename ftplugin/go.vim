let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
nmap <leader>1  <Plug>(go-build)
nmap <leader>2  <Plug>(go-test)
nmap <leader>3  <Plug>(go-run)
nmap <leader>r  <Plug>(go-rename)
nmap <leader>]  <Plug>(go-def)
inoremap {<CR> {<CR>}<ESC>O