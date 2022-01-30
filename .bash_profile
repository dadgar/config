source ~/.config/liquidpromptrc
if [ -f /opt/homebrew/share/liquidprompt ]; then
  . /opt/homebrew/share/liquidprompt
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export CLICOLOR=1;
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Dont show the same command in history
export HISTCONTROL=ignoredups

alias hashi="cd ~/go/src/github.com/hashicorp/"
alias ndev="cd ~/go/src/github.com/hashicorp/nomad/"

#Home Brew
export PATH=/opt/homebrew/bin/:/usr/local/bin:/usr/local/sbin:$PATH

# GO
export GOPATH="/Users/alexdadgar/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/usr/local/go/bin

# AWS
export AWS_REGION=us-west-2
export AWS_ACCESS_KEY_ID=XXX
export AWS_SECRET_ACCESS_KEY=XXX

# GIT
alias git=hub

# Brew bash completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Vagrant
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# Better history
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)

source ~/.bashrc
