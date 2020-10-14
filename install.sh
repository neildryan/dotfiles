#! /bin/bash

set -e

DOTFILES=~/.files
ITERM=com.googlecode.iterm2.plist

# Get some essentials
if [[ "$OSTYPE" == "darwin"* ]]; then  #OSX
    # Install Brew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew cask install iterm2
    brew install zsh-syntax-highlighting the_silver_searcher wget fzf neovim
    /usr/local/opt/fzf/install
    brew install reattach-to-user-namespace shellcheck htop tldr
    cp "$DOTFILES/$ITERM" "$HOME/Documents/"
    cp "$DOTFILES/fonts/*" "$HOME/Library/Fonts/"
    open "$DOTFILES/one_dark.itermcolors"
else # Debian Linux
    sudo apt update
    sudo apt -y install make wget curl python3 cmake tldr
    sudo apt -y install zsh zsh-common neovim silversearcher-ag
    sudo apt -y install zsh-syntax-highlighting
    sudo apt -y install powertop tlp htop
    sudo apt -y install gnome-tweak-tool chrome-gnome-shell
    sudo apt -y dist-upgrade && sudo apt -y autoremove
    mkdir -p "$HOME/.fonts"
    cp $DOTFILES/fonts/* $HOME/.fonts
    sudo fc-cache -vf ~/.fonts
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

# Get typewritten prompt
git clone https://github.com/reobin/typewritten.git "$DOTFILES/typewritten"

# Set shell to zsh
if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh $USER
fi

# Setup symlinks
ln -s -f "$DOTFILES/zshrc" "$HOME/.zshrc"
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
echo "See install-extra.sh for system setup"
