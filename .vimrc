source $HOME/.vim/vimrc
if filereadable(expand('~/.vimrc.local'))
  execute 'source' fnameescape(expand('~/.vimrc.local'))
endif
