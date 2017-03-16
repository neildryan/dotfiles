#! /bin/bash

DOTFILES=$HOME/.files/

ln -s $DOTFILES/zshrc $HOME/.zshrc
ln -s $DOTFILES/gitignore $HOME/.gitignore
ln -s $DOTFILES/gdbinit $HOME/.gdbinit
ln -s $DOTFILES/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/.gitconfig $HOME/.gitconfig
