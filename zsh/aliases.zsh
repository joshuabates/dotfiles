# Machine
alias psg='ps aux | grep'

alias vi='nvim'
alias vim='nvim'

# Rails
alias rsc='ruby script/rails c'
alias b='bundle exec'
alias b!='bundle exec $(history -p !!)'
alias s!='sudo $(history -p !!)'
alias bri="bundle list | tr -d '*(,)' | awk '{print $1, \"--version\", $2}' | xargs -n3 gem rdoc --ri --no-rdoc"

# Navigation
alias p='cd ~/Projects'
alias x='exit'
alias ls='ls -G'
alias cp='cp -r'

# Git
alias g='git'
alias gl="git log"
alias gs='git st'
alias gb='git branch -a'
alias ga='git add'
alias gci='git ci'
alias gr='git rebase'
alias gri='git rebase --interactive'
alias gres='git reset --soft'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gd='git diff'
alias gl='git pull'
alias gp='git push'
alias gstag='git diff --cached --stat'
alias gmt='git mergetool'
alias gm='git co master'
alias gap='git add --patch'
alias gnb='git co -b'
alias grh='git reset HEAD'
alias gpr='git pull --rebase'
alias gsc='git stash clear'
alias grc='git rebase --continue'
alias gsl='git show $(git stash list | cut -d":" -f 1)'
alias gsp='git stash && git pull && git stash pop'
