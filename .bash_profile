source ~/.config/liquidpromptrc
source ~/liquidprompt/liquidprompt
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export CLICOLOR=1;
#export TERM=xterm-256color
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Dont show the same command in history
export HISTCONTROL=ignoredups

export JAVA_HOME=$(/usr/libexec/java_home)

alias hashi="cd ~/Projects/go/src/github.com/hashicorp/"
alias ndev="cd ~/Projects/go/src/github.com/hashicorp/nomad/"

#Home Brew
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin/terraform_0:$PATH

# GO
export GOPATH="/Users/adadgar/Projects/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/usr/local/go/bin

# AWS
export AWS_REGION=us-west-2
export AWS_ACCESS_KEY_ID=XXX
export AWS_SECRET_ACCESS_KEY=XXX

# Flame graphs
export PATH=$PATH:/usr/local/bin/FlameGraph

# GIT
alias git=hub

# Brew bash completions
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# Pip
export PATH="/Users/adadgar/Library/Python/2.7/lib/python/site-packages:$PATH"

# Vagrant
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# Better history
# Tool: https://github.com/dvorka/hstr
export HH_CONFIG=hicolor         # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"   # mem/file sync
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hh -- \C-j"'; fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
source ~/.bashrc
