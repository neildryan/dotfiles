#! /bin/bash

DOTFILES=$HOME/.files/
ITERM=com.googlecode.iterm2.plist

# Get some essentials
if [[ "$OSTYPE" == "darwin"* ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install zsh-syntax-highlighting
    brew cask install iterm2
    brew install the_silver_searcher
    cp $DOTFILES/$ITERM ~/Documents/$ITERM
else
    sudo add-apt-repository ppa:webupd8team/terminix
    sudo apt-get update
    sudo apt-get -y install make wget curl git python python3
    sudo apt-get -y install zsh zsh-common vim vim-common vim-runtime vim-tiny
    sudo apt-get -y install silversearcher-ag
    sudo apt-get -y install tilix
    sudo apt-get -y autoremove
fi


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
ln -s $DOTFILES/vimrc $HOME/.config/nvim/init.vim
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
vim -c "PlugInstall" -c "qall"


source ~/.zshrc
