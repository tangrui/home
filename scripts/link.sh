[ -f ~/.curlrc ]                && mv ~/.curlrc                 ~/.curlrc.bak
[ -f ~/.gitconfig ]             && mv ~/.gitconfig              ~/.gitconfig.bak
[ -f ~/.gitignore ]             && mv ~/.gitignore              ~/.gitignore.bak
[ -f ~/.gitignore_global ]      && mv ~/.gitignore_global       ~/.gitignore_global.bak
[ -d ~/.hgext ]                 && mv ~/.hgext                  ~/.hgext.bak
[ -f ~/.hgignore_global ]       && mv ~/.hgignore_global        ~/.hgignore_global.bak
[ -f ~/.hgrc ]                  && mv ~/.hgrc                   ~/.hgrc.bak
[ -f ~/.kdiff3rc ]              && mv ~/.kdiff3rc               ~/.kdiff3rc.bak
[ -f ~/.mavenrc ]               && mv ~/.mavenrc                ~/.mavenrc.bak
[ -f ~/.npmrc ]                 && mv ~/.npmrc                  ~/.npmrc.bak
[ -f ~/.profile ]               && mv ~/.profile                ~/.profile.bak
[ -d ~/.vim ]                   && mv ~/.vim                    ~/.vim.bak
[ -d ~/.tmux ]                  && mv ~/.tmux                   ~/.tmux.bak
[ -f ~/.tmux.conf ]             && mv ~/.tmux.conf              ~/.tmux.conf.bak
[ -f ~/.oh-my-zsh/custom ]      && mv ~/.oh-my-zsh/custom       ~/.oh-my-zsh/custom.bak
[ -f ~/.zshrc ]                 && mv ~/.zshrc                  ~/.zshrc.bak


ln -s ~/Home/.curlrc            ~/.curlrc
ln -s ~/Home/.gitconfig         ~/.gitconfig
ln -s ~/Home/.gitignore         ~/.gitignore
ln -s ~/Home/.gitignore_global  ~/.gitignore_global
ln -s ~/Home/.hgext             ~/.hgext
ln -s ~/Home/.hgignore_global   ~/.hgignore_global
ln -s ~/Home/.hgrc              ~/.hgrc
ln -s ~/Home/.kdiff3rc          ~/.kdiff3rc
ln -s ~/Home/.mavenrc           ~/.mavenrc
ln -s ~/Home/.npmrc             ~/.npmrc
ln -s ~/Home/.profile           ~/.profile
ln -s ~/Home/.vim               ~/.vim
ln -s ~/Home/.tmux              ~/.tmux
ln -s ~/Home/.tmux.conf         ~/.tmux.conf
ln -s ~/Home/.oh-my-zsh/custom  ~/.oh-my-zsh/custom
ln -s ~/Home/.zshrc             ~/.zshrc
