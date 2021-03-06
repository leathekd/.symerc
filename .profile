#if [ -r /etc/profile.d/nix.sh ] ; then
#    source /etc/profile.d/nix.sh
#    unset NIX_REMOTE # wups
#fi

export PATH=$HOME/bin:$PATH
export PATH=$HOME/.gem/ruby/1.9.1/bin:/var/lib/gems/1.9.1/bin:$PATH
export PATH=/usr/lib/postgresql/8.4/bin:$PATH
export PATH=/usr/lib/postgresql/9.1/bin:$PATH

export CDPATH=.:$HOME/src

# plz don't make me sudo
export GEM_HOME=$HOME/.gem/ruby/1.9.1

export EDITOR="emacsclient"

export DEBEMAIL="leathekd@gmail.com"
export DEBFULLNAME="David Leatherman"

export PROFILE_LOADED=y

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
