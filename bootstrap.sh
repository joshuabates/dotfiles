distribution=`uname -s`
if [[$distribution == 'Darwin']]; then
  ./bootstrap/osx
elif [[$distribution == 'Linux']]; then
  ./bootstrap/linux.sh
fi

git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
npm install --global pure-prompt

env RCRC=$HOME/.dotfiles/rcrc rcup

mkdir -p ~/.vim/autoload
curl -fLo ~/.vim/autoload/plug.vim \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim -c PlugInstall -c quitall
