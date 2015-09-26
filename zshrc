if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

. `brew --prefix`/etc/profile.d/z.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh/aliases.zsh
source ~/.zsh/env.zsh
source ~/.zsh/opts.zsh
source ~/.zsh/key-bindings.zsh
source ~/.zsh/commands.zsh

for plugin in ~/.zsh/plugins/**/*.zsh; do
  source $plugin
done

# history settings
setopt appendhistory histignoredups
setopt histignorespace extended_history
setopt INC_APPEND_HISTORY share_history
SAVEHIST=8096
HISTSIZE=8096

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

if which direnv &>/dev/null ; then
  eval "$(direnv hook zsh)"
fi

export NVM_DIR=$(brew --prefix)/var/nvm
source $(brew --prefix nvm)/nvm.sh

export PATH=./bin:"$PATH"
