if [[ "$(uname)" == "Darwin" ]]; then
  ./bootstrap/osx.sh
elif [[ "$(expr substr $(uname -s) 1 5)" == "Linux" ]]; then
  ./bootstrap/linux.sh
fi

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
env RCRC=$HOME/.dotfiles/rcrc rcup

mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c PlugInstall -c quitall

# restart shell
su -l `whoami`
