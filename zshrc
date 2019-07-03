if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if which brew &>/dev/null ; then
  . `brew --prefix`/etc/profile.d/z.sh
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,tmp,log,vcr_cassettes}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source ~/.zsh/aliases.zsh
source ~/.zsh/env.zsh
source ~/.zsh/key-bindings.zsh
source ~/.zsh/commands.zsh

# for plugin in ~/.zsh/plugins/**/*.zsh; do
#  source $plugin
#done

DISABLE_CORRECTION="true"
unsetopt correct
setopt nocorrectall
stty icrnl

# disable ctrl-d to logout
setopt IGNORE_EOF

# history settings
setopt appendhistory histignoredups
setopt histignorespace extended_history
setopt INC_APPEND_HISTORY share_history
SAVEHIST=8096
HISTSIZE=8096

if which direnv &>/dev/null ; then
  eval "$(direnv hook zsh)"
fi

export PATH=./bin:"$PATH"
export PATH=/Users/joshua/Library/Python/2.7/bin:"$PATH"

export PATH="$HOME/.yarn/bin:$PATH"

. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# asdf_update_java_home() {
#   local current
#   if current=$(asdf current java); then
#     local version=$(echo $current | sed -e 's|\(.*\) \?(.*|\1|g')
#     export JAVA_HOME=$(asdf where java $version)
#   else
#     echo "No java version set. Type `asdf list-all java` for all versions."
#   fi
# }
# asdf_update_java_home
