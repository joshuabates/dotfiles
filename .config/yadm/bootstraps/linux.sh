#!/bin/sh
trap 'ret=$?; test $ret -ne 0 && printf "failed\n\n" >&2; exit $ret' EXIT
set -e

laptop_echo() {
  local fmt="$1"; shift

  # shellcheck disable=SC2059
  printf "\\n[LAPTOP] $fmt\\n" "$@"
}

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

exec ssh-agent bash
ssh-add

sudo apt-get install software-properties-common python-software-properties

sudo apt-get update

sudo apt-get install zsh vim-nox tmux nodejs docker-engine rcm autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev htop curl -y

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
