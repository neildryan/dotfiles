#! /bin/bash

DOTFILES=$HOME/.files/

# Get some essentials
sudo apt-get update
sudo apt-get -y install make wget curl git
sudo apt-get -y install zsh zsh-common vim vim-common vim-runtime
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade

# Get oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh

# Setup symlinks so programs work
ln -s $DOTFILES/zshrc $HOME/.zshrc
ln -s $DOTFILES/gitignore $HOME/.gitignore
ln -s $DOTFILES/gdbinit $HOME/.gdbinit
ln -s $DOTFILES/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/gitconfig $HOME/.gitconfig
ln -s $DOTFILES/vimrc $HOME/.vimrc

# Complete vim setup
vim -S setup_vim_cmd

source ~/.zshrc
