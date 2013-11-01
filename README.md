# dot symerc

User-level configuration for collaborating on [Syme](https://syme.herokuapp.com).

To create your own, simply make a `.symerc` repo under your GitHub
username that includes an executable `bootstrap` script which copies
your dotfiles into place and installs whatever packages you like. This
script will be run from the home directory with the user-qualified
GitHub project being worked on (eg. "technomancy/syme") as its
argument. It will have access to passwordless sudo.
