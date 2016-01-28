setopt INC_APPEND_HISTORY
# zstyle ':prezto:*:*' case-sensitive 'no'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
DISABLE_CORRECTION="true"
unsetopt correct
setopt nocorrectall
stty icrnl

# disable ctrl-d to logout
setopt IGNORE_EOF
