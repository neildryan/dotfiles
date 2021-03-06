#! /bin/bash

set -e

if [[ "$OSTYPE" == "darwin"* ]]; then  # OSX
    brew update
    brew install hugo msgpack pipenv cmake npm telnet radare2 python3
    pip3 install numpy matplotlib neovim pycodestyle
    brew doctor
    brew prune
    brew cleanup
    echo "macpass, itsycal, Office, Slack, Spark!"
else # Debian Linux
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
    sudo add-apt-repository ppa:snwh/pulp
    sudo apt-get -y install texlive-full
    sudo apt-get -y install okular openconnect
    sudo apt-get -y install pep8 pycodestyle python-pip
    sudo apt-get -y install keepassx pinta radare2 vlc
    sudo apt-get -y install paper-icon-theme paper-cursor-theme arc-theme
    sudo apt-get -y install jackd patchage qsynth
    sudo snap install tldr
fi
