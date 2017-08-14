#! /bin/bash

DOTFILES=$HOME/.files/
ITERM=com.googlecode.iterm2.plist

# Get some essentials
if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew cask install iterm2
    brew install zsh-syntax-highlighting the_silver_searcher tmux reattach-to-user-namespace
    brew link --overwrite tmux
    cp "$DOTFILES/$ITERM" "$HOME/Documents/$ITERM"
    cp "$DOTFILES/fonts/*" "$HOME/Library/Fonts"
    open "$DOTFILES/one_dark.itermcolors"
else # Debian Linux
    sudo apt-get update
    sudo apt-get -y install make wget curl git python python3
    sudo apt-get -y install zsh zsh-common neovim tmux silversearcher-ag
    sudo apt-get -y autoremove
    mkdir -p "$HOME/.fonts" && cp "$DOTFILES/fonts/*" "$HOME/.fonts"
    sudo fc-cache -vf ~/.fonts
fi

# Get oh-my-zsh, set shell to zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

# Setup symlinks
ln -s -f "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -s -f "$DOTFILES/gitignore" "$HOME/.gitignore"
ln -s -f "$DOTFILES/gdbinit" "$HOME/.gdbinit"
mkdir -p "$HOME/.config/nvim"
ln -s -f "$DOTFILES/vimrc" "$HOME/.config/nvim/init.vim"
ln -s -f "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s -f "$DOTFILES/vimrc" "$HOME/.vimrc"
ln -s -f "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"

# Complete vim setup
nvim -c "PlugInstall" -c "qall"

source "$HOME/.zshrc"
