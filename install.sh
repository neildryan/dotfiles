#! /bin/bash

DOTFILES=$HOME/.files/
ITERM=com.googlecode.iterm2.plist

# Get some essentials
if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install zsh-syntax-highlighting
    brew cask install iterm2
    brew install the_silver_searcher
    brew install tmux
    brew link --overwrite tmux
    brew install reattach-to-user-namespace
    cp "$DOTFILES/$ITERM" "$HOME/Documents/$ITERM"
    cp "$DOTFILES/fonts/*" "$HOME/Library/Fonts"
    open "$DOTFILES/one_dark.itermcolors"
else
    sudo apt-get update
    sudo apt-get -y install make wget curl git python python3
    sudo apt-get -y install zsh zsh-common neovim tmux
    sudo apt-get -y install silversearcher-ag
    sudo apt-get -y autoremove
    mkdir -p "$HOME/.fonts"
    cp "$DOTFILES/fonts/*" "$HOME/.fonts"
    sudo fc-cache -vf ~/.fonts
fi

# Get oh-my-zsh, set shell to zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
chsh -s /bin/zsh

# Remove symlinks if they exist
rm -f "$HOME/.zshrc"
rm -f "$HOME/.gitignore"
rm -f "$HOME/.gdbinit"
rm -f "$HOME/.config/nvim/init.vim"
rm -f "$HOME/.gitconfig"
rm -f "$HOME/.vimrc"
rm -f "$HOME/.tmux.conf"

# Setup symlinks
ln -s "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -s "$DOTFILES/gitignore" "$HOME/.gitignore"
ln -s "$DOTFILES/gdbinit" "$HOME/.gdbinit"
mkdir -p "$HOME/.config/nvim"
ln -s "$DOTFILES/vimrc" "$HOME/.config/nvim/init.vim"
ln -s "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s "$DOTFILES/vimrc" "$HOME/.vimrc"
ln -s "$DOTFILES/tmux.conf" "$HOME/.tmux.conf"

# Complete vim setup
nvim -c "PlugInstall" -c "qall"

source "$HOME/.zshrc"
