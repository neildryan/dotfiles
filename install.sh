#! /bin/bash

DOTFILES=$HOME/.files/

# Get some essentials
sudo apt-get update
sudo apt-get -y install make wget curl git
sudo apt-get -y install zsh zsh-common vim vim-common vim-runtime


# Get oh-my-zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
cp ~/.zshrc ~/.zshrc.orig
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
chsh -s /bin/zsh


# Remove symlinks if they exist
rm -f $HOME/.zshrc
rm -f $HOME/.gitignore
rm -f $HOME/.gdbinit
rm -f $HOME/.config/nvim/init.vim
rm -f $HOME/.gitconfig
rm -f $HOME/.vimrc

# Setup symlinks so programs work
ln -s $DOTFILES/zshrc $HOME/.zshrc
ln -s $DOTFILES/gitignore $HOME/.gitignore
ln -s $DOTFILES/gdbinit $HOME/.gdbinit
mkdir -p $HOME/.config/nvim/init.vim
ln -s $DOTFILES/init.vim $HOME/.config/nvim/init.vim
ln -s $DOTFILES/gitconfig $HOME/.gitconfig
ln -s $DOTFILES/vimrc $HOME/.vimrc

# Get fonts to play nice with agnoster
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts
mv PowerlineSymbols.otf ~/.fonts
mkdir -p .config/fontconfig/conf.d
fc-cache -vf ~/.fonts
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d

# Complete vim setup
vim -S setup_vim_cmd


source ~/.zshrc
