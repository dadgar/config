source ~/config/.liquidpromptrc
source ~/liquidprompt/liquidprompt

export CLICOLOR=1;
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

export JAVA_HOME=$(/usr/libexec/java_home)

alias hashi="cd ~/Projects/go/src/github.com/hashicorp/"
alias ndev="cd ~/Projects/go/src/github.com/hashicorp/nomad/"

#Home Brew
export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin/terraform_0:$PATH

# GO
export GOPATH="/Users/adadgar/Projects/go"
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN:/usr/local/go/bin

# GIT
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    . `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi
