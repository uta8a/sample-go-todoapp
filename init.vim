" leader key == ','
let mapleader = ","


call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-default branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'rbtnn/vim-vimscript_indentexpr'
" Initialize plugin system
call plug#end()

" Defx
" , f
nnoremap <silent> <Leader>f :<C-u> Defx <CR>

call defx#custom#option('_', {
			\ 'show_ignored_files': 1,
			\ 'buffer_name': 'explorer',
			\ 'toggle': 1,
			\ 'resume': 1,
			\ })

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	" Define mappings
	nnoremap <silent><buffer><expr> <CR>
				\ defx#do_action('open')
	nnoremap <silent><buffer><expr> c
				\ defx#do_action('copy')
	nnoremap <silent><buffer><expr> m
				\ defx#do_action('move')
	nnoremap <silent><buffer><expr> p
				\ defx#do_action('paste')
	nnoremap <silent><buffer><expr> l
				\ defx#do_action('open')
	nnoremap <silent><buffer><expr> E
				\ defx#do_action('open', 'vsplit')
	nnoremap <silent><buffer><expr> P
				\ defx#do_action('preview')
	nnoremap <silent><buffer><expr> o
				\ defx#do_action('open_tree', 'toggle')
	nnoremap <silent><buffer><expr> K
				\ defx#do_action('new_directory')
	nnoremap <silent><buffer><expr> N
				\ defx#do_action('new_file')
	nnoremap <silent><buffer><expr> M
				\ defx#do_action('new_multiple_files')
	nnoremap <silent><buffer><expr> C
				\ defx#do_action('toggle_columns',
				\                'mark:indent:icon:filename:type:size:time')
	nnoremap <silent><buffer><expr> S
				\ defx#do_action('toggle_sort', 'time')
	nnoremap <silent><buffer><expr> d
				\ defx#do_action('remove')
	nnoremap <silent><buffer><expr> r
				\ defx#do_action('rename')
	nnoremap <silent><buffer><expr> !
				\ defx#do_action('execute_command')
	nnoremap <silent><buffer><expr> x
				\ defx#do_action('execute_system')
	nnoremap <silent><buffer><expr> yy
				\ defx#do_action('yank_path')
	nnoremap <silent><buffer><expr> .
				\ defx#do_action('toggle_ignored_files')
	nnoremap <silent><buffer><expr> ;
				\ defx#do_action('repeat')
	nnoremap <silent><buffer><expr> h
				\ defx#do_action('cd', ['..'])
	nnoremap <silent><buffer><expr> ~
				\ defx#do_action('cd')
	nnoremap <silent><buffer><expr> q
				\ defx#do_action('quit')
	nnoremap <silent><buffer><expr> <Space>
				\ defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> *
				\ defx#do_action('toggle_select_all')
	nnoremap <silent><buffer><expr> j
				\ line('.') == line('$') ? 'gg' : 'j'
	nnoremap <silent><buffer><expr> k
				\ line('.') == 1 ? 'G' : 'k'
	nnoremap <silent><buffer><expr> <C-l>
				\ defx#do_action('redraw')
	nnoremap <silent><buffer><expr> <C-g>
				\ defx#do_action('print')
	nnoremap <silent><buffer><expr> cd
				\ defx#do_action('change_vim_cwd')
endfunction

" ref. https://qiita.com/fleur_071/items/54156f52b4ed6ce83630
" `nvim .` した時にDefxを自動起動

function! s:open_defx_if_directory()
	" This throws an error if the buffer name contains unusual characters like
	" [[buffergator]]. Desired behavior in those scenarios is to consider the
	" buffer not to be a directory.
	try
		let l:full_path = expand(expand('%:p'))
	catch
		return
	endtry

	" If the path is a directory, delete the (useless) buffer and open defx for
	" that directory instead.
	if isdirectory(l:full_path)
		Defx `expand('%:p')`
	endif
endfunction

augroup defx_config
	autocmd!
	autocmd FileType defx call s:defx_my_settings()

	" It seems like BufReadPost should work for this, but for some reason, I can't
	" get it to fire. BufEnter seems to be more reliable.
	autocmd BufEnter * call s:open_defx_if_directory()
augroup END

