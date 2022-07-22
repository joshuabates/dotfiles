#!/bin/sh
set -e

exec ssh-agent bash
ssh-add

sudo apt-get install software-properties-common python-software-properties

wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list

sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'


sudo apt-get update

sudo apt-get install zsh vim-nox tmux nodejs docker-engine rcm autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev htop curl -y
sudo usermod -aG docker $(whoami)

if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

if [ ! -d ~/.rbenv ]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
fi

# install nvm?
# install jq
# install innotop
# install aws tools
# chsh -s /bin/zsh
