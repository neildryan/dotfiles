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
    sudo add-apt-repository ppa:snwh/pulp
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get -y install make wget curl git python python3 cmake doxygen
    sudo apt-get -y install zsh zsh-common neovim tmux silversearcher-ag
    sudo apt-get -y install zsh-syntax-highlighting
    sudo apt-get -y install paper-icon-theme paper-cursor-theme
    sudo apt-get -y install arc-theme
    sudo apt-get -y install python-pip docker powertop tlp
    sudo apt-get -y install multiarch-suppport libc6:i386 libncurses5:i386
    sudo apt-get -y install keepassx audacity pinta radare2 virtualbox
    sudo apt-get -y install virtualbox-ext-pack
    sudo apt-get -y install youtube-dl mkchromecast
    sudo apt-get -y install gnome-tweak-tool chrome-gnome-shell gnome-shell-pomodoro
    sudo apt-get -y install spotify-client
    sudo apt-get -y dist-upgrade
    sudo apt-get -y autoremove
    mkdir -p "$HOME/.fonts"
    cp $DOTFILES/fonts/* $HOME/.fonts
    sudo fc-cache -vf ~/.fonts
    rmdir ~/Videos ~/Templates ~/Music ~/Public
    echo "\n\n"
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
echo "\n\n"
echo "1) spotify and google-chrome-stable"
echo "2) texlive-full"
echo "3) mkchromecast requirements"
