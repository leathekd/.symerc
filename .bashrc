# .bashrc

# prompt coloring
# see http://attachr.com/9288 for full-fledged craziness
if [ `/usr/bin/whoami` = "root" ] ; then
  # root has a red prompt
  export PS1="\[\033[1;31m\]\u@\h \w \$ \[\033[0m\]"
elif [ `hostname` = "zuse" -o `hostname` = "enigma" -o `hostname` = "dynabook" ] ; then
  # the hosts I use on a daily basis have blue
  export PS1="\[\033[1;36m\]\u@\h \w \$ \[\033[0m\]"
elif [ `hostname` == domU* -o `hostname` = "lucid" -o `hostname` = "vagrant" ]; then
  # green on VMs (EC2, vbox, etc)
  export PS1="\[\033[1;32m\]\u@\h \w \$ \[\033[0m\]"
else
  # purple for unknown hosts
  export PS1="\[\033[1;35m\]\u@\h \w \$ \[\033[0m\]"
fi

function fix-agent {
  SOCKETS=`find /tmp/ -uid $UID -path \*ssh\* -type s 2> /dev/null`
  export SSH_AUTH_SOCK=$(ls --color=never -t1 $SOCKETS | head -1)
  ssh-add -l
}

# Source from elsewhere
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

if [ -f $HOME/.bash_aliases ]; then
  . $HOME/.bash_aliases
fi

if [ -f $HOME/src/leiningen/bash_completion.bash ]; then
  . $HOME/src/leiningen/bash_completion.bash
fi

if [ -f /etc/bash_completion.d/git ]; then
  . /etc/bash_completion.d/git
fi

# Enter sensitive lines (containing passwords, etc) with a leading
# space so they don't show up in history.
HISTCONTROL=ignoreboth:erasedups

# currently a tmux bug causes this horrible hack to be necessary.
# tmux sources .bashrc but not profile for some reason
if [ "$PROFILE_LOADED" = "" ]; then
    . $HOME/.profile
fi

[ -z "$TMUX" ] && export TERM=xterm-256color

# lazy-load this since it's slow
function cloud () {
    eval "$(ion-client shell)"
    cloud $1
}

export JAVA_CMD=/usr/bin/java

tmux new -s "syme-session" -A
