sudo aptitude install zsh vim-nox tmux

# If full install
  # curl -fLo zsh.tar.gz https://downloads.sourceforge.net/project/zsh/zsh/5.1.1/zsh-5.1.1.tar.gz
  # tar -xzvf zsh.tar.gz
  # cd zsh-5.1.1
  # ./configure --prefix=/usr/local
  # make
  # sudo make install
  # cd --

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

wget https://thoughtbot.github.io/rcm/debs/rcm_1.2.3-1_all.deb
sudo dpkg -i rcm_1.2.3-1_all.deb
# install rbenv?
# install nvm?
# install jq
# install innotop
# install aws tools
chsh -s /usr/local/bin/zsh
