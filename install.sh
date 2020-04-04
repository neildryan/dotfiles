#! /bin/bash

# TODO probably easier to just pull fonts down from Google Fonts

set -e

DOTFILES=~/.files
ITERM=com.googlecode.iterm2.plist

# Get some essentials
if [[ "$OSTYPE" == "darwin"* ]]; then  #OSX
    # Install Brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew cask install iterm2
    brew install zsh-syntax-highlighting the_silver_searcher wget fzf
    brew install neovim
    /usr/local/opt/fzf/install
    brew install reattach-to-user-namespace shellcheck
    cp "$DOTFILES/$ITERM" "~/Documents/"
    cp "$DOTFILES/fonts/*" "$HOME/Library/Fonts/"
    open "$DOTFILES/one_dark.itermcolors"
else # Debian Linux
    sudo apt-get update
    sudo apt-get -y install make wget curl python3 cmake
    sudo apt-get -y install zsh zsh-common neovim silversearcher-ag
    sudo apt-get -y install zsh-syntax-highlighting
    sudo apt-get -y install docker powertop tlp
    sudo apt-get -y install gnome-tweak-tool chrome-gnome-shell
    sudo apt-get -y dist-upgrade && sudo apt-get -y autoremove
    mkdir -p "$HOME/.fonts"
    cp "$DOTFILES/fonts/*" "$HOME/.fonts"
    sudo fc-cache -vf ~/.fonts
    rmdir ~/Videos ~/Templates ~/Music ~/Public
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# Get oh-my-zsh, set shell to zsh
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
fi

# Setup symlinks
ln -s -f "$DOTFILES/zshrc" "$HOME/.zshrc"
ln -s -f "$DOTFILES/zshenv" "$HOME/.zshenv"
ln -s -f "$DOTFILES/gitignore" "$HOME/.gitignore"
ln -s -f "$DOTFILES/gdbinit" "$HOME/.gdbinit"
mkdir -p "$HOME/.config/nvim"
ln -s -f "$DOTFILES/vimrc" "$HOME/.config/nvim/init.vim"
ln -s -f "$DOTFILES/gitconfig" "$HOME/.gitconfig"
ln -s -f "$DOTFILES/vimrc" "$HOME/.vimrc"

# Complete vim setup
nvim -c "PlugInstall" -c "qall"

source "$HOME/.zshrc"
printf "\n\n"
echo "install-extra.sh for other things!"
