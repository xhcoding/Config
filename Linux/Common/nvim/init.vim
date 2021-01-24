" 插件管理
" 指定插件的目录
call plug#begin('~/.local/share/nvim/plugged')
" 目录树插件
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 文件查找
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }

" 主题
Plug 'joshdick/onedark.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Initialize plugin system
call plug#end() 

" 开启语法高亮
syntax on

set tabstop=4
set shiftwidth=4
set expandtab

" 主题设置
colorscheme onedark

"==========插件配置=================
" 目录树
let g:NERDTreeNotificationThreshold = 500

" airline
let g:airline_theme='onedark'

"===================================



"==========快捷键配置===============
" 设置leader键
let mapleader="\<Space>"

" jk退出插入模式
ino <nowait> jk <Esc>
" 重新载入配置
nn <silent> <leader>hR :source ~/.vim/vimrc

" 窗口相关
nn <silent> <leader>wk :wincmd k<cr>
nn <silent> <leader>wj :wincmd j<cr>
nn <silent> <leader>wh :wincmd h<cr>
nn <silent> <leader>wl :wincmd l<cr>
nn <silent> <leader>wq :wincmd q<cr>
nn <silent> <leader>wv :vsplit<cr>
nn <silent> <leader>ws :split<cr>

" buffer相关
nn <silent> <leader>bs :write<cr>

" 文件相关
" 打开最近文件
nn <silent> <leader>fr :Leaderf mru<cr>
" 打开当前目录文件
nn <silent> <leader>f. :Leaderf file .<cr>


" 打开目录树
nn <silent> <leader>op :NERDTreeToggle<cr>

" LSP相关按键
nn <silent> gd :call LanguageClient#textDocument_definition()<cr>
nn <silent> gD :call LanguageClient#textDocument_references({'includeDeclaration': v:false})<cr>
nn <silent> K :call LanguageClient#textDocument_hover()<cr>
"===================================
