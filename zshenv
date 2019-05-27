# User configuration {{{
export LANG=en_US.UTF-8

if hash nvim 2> /dev/null; then
    export EDITOR='nvim'
    export VISUAL='nvim'
else
    export EDITOR='vim'
    export VISUAL='vim'
fi
# Compilation flags
export ARCHFLAGS="-arch x86_64"
export DEFAULT_USER="neilryan"
export BAT_THEME="TwoDark"
#}}}
# Path changes{{{
export PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin
if [[ "$OSTYPE" != "darwin"* ]]; then
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
    fi
    export PATH=$PATH:/snap/bin
else
    export PATH=$PATH:~/Library/Python/3.7/bin
fi
# }}}
# vim:foldmethod=marker:foldlevel=0
