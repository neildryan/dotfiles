#! /bin/bash

set -e

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
sudo add-apt-repository ppa:snwh/pulp
sudo apt-get -y install audacity ardour hydrogen cecilia musescore
sudo apt-get -y install texlive-full
sudo apt-get -y install kdeconnect okular
sudo apt-get -y install openconnect
sudo apt-get -y install pep8 pycodestyle python-pip
sudo apt-get -y install htop
sudo apt-get -y install keepassx pinta radare2
sudo apt-get -y install paper-icon-theme paper-cursor-theme arc-theme
sudo apt-get -y install jackd patchage qsynth
sudo snap install spotify

echo "1)  google-chrome-stable"
echo "git clone git@github.com:CMUAbstract/cnn-graph-sim.git"
