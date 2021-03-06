# export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
# export _JAVA_OPTIONS=-Djava.awt.headless=true
export NODE_PATH="/usr/local/lib/node"

export EC2_AMITOOL_HOME="/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
export EC2_HOME="$HOME/.ec2"
export AWS_REGION=us-east-1
export KITTY_LISTEN_ON=/tmp/mykitty

if [[ -s "$HOME/.ec2" ]]; then
  export AWS_ACCESS_KEY=`cat ~/.ec2/AWS_ACCESS_KEY`
  export AWS_SECRET_KEY=`cat ~/.ec2/AWS_SECRET_KEY`
fi

export LC_CTYPE=en_US.UTF-8
export EDITOR="nvim"
export EVENT_NOKQUEUE=1
export FD_SETSIZE=10000

export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad

export PATH=./node_modules/:/usr/local/bin:/usr/local/sbin:~/bin:/usr/local/share/npm/bin/:$PATH
