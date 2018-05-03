#!/bin/bash
set -e

if [[ "$(uname)" == "Darwin" ]]; then
  ./bootstrap/osx.sh
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  ./bootstrap/linux.sh
fi

python2 -m pip install --upgrade setuptools
python2 -m pip install --upgrade pip
python2 -m pip install --user tmuxp

if [[ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

env RCRC=$HOME/.dotfiles/rcrc rcup

setopt EXTENDED_GLOB

mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c PlugInstall -c quitall

# restart shell
su -l `whoami`
