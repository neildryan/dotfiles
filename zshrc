# Path to your oh-my-zsh installation. {{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    export ZSH=/Users/neilryan/.oh-my-zsh
else
    export ZSH=/home/neilryan/.oh-my-zsh
fi
#}}}
# Theme {{{
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="agnoster"
#}}}
# Other ZSH config {{{
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
#}}}
# Oh-my-zsh config {{{
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# TODO ADD gitfast
if [[ "$OSTYPE" == "darwin"* ]]; then
    plugins=(git ssh-agent colorize colored-man-pages cp)
else
    plugins=(git colorize colored-man-pages)
fi
source $ZSH/oh-my-zsh.sh
#}}}
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

setopt correct
export DEFAULT_USER="neilryan"
export MARKPATH=~/.files/marks

export BAT_THEME="TwoDark"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#}}}
# Aliases {{{
# For a full list of active aliases, run `alias`.
bindkey -r "^o"
bindkey -r "^l"
bindkey "^o" clear-screen

alias r2="r2 -A"
if [[ "$OSTYPE" != "darwin"* ]]; then
    alias open='xdg-open'
fi

if hash nvm 2> /dev/null; then
    alias vim="nvim"
fi
if hash htop 2> /dev/null; then
    alias top='htop'
fi
if hash bat 2> /dev/null; then
    alias cat='bat'
fi
if hash prettyping 2> /dev/null; then
    alias ping='prettyping --nolegend'
fi
#}}}
#Functions {{{
bookmark() { # From https://vincent.bernat.im/en/blog/2015-zsh-directory-bookmarks {{{
    if (( $# == 0 )); then
        # When no arguments are provided, just display existing
        # bookmarks
        for link in $MARKPATH/*(N@); do
            local markname="$fg[green]${link:t}$reset_color"
            local markpath="$fg[blue]${link:A}$reset_color"
            printf "%-30s -> %s\n" $markname $markpath
        done
    else
        # Otherwise, we may want to add a bookmark or delete an
        # existing one.
        local -a delete
        zparseopts -D d=delete
        if (( $+delete[1] )); then
            # With `-d`, we delete an existing bookmark
            command rm "$MARKPATH/$1"
        else
            # Otherwise, add a bookmark to the current
            # directory. The first argument is the bookmark
            # name. `.` is special and means the bookmark should
            # be named after the current directory.
            local name=$1
            if [[ $name == "." ]]; then
                name=${PWD:t}
            fi
            ln -s $PWD $MARKPATH/$name
            hash -d -- $name=$PWD
        fi
    fi
}
#}}}
#}}}
# Bookmark Setup {{{
for link in $MARKPATH/*(N@); do
    hash -d -- "${link:t}=${link:A}"
done
# }}}
# Path changes{{{
export PATH=$PATH:~/.files/util
export PATH=$PATH:~/Dropbox/bin
export PATH=$PATH:/snap/bin
if [[ "$OSTYPE" != "darwin"* ]]; then
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
    fi
fi
#}}}
# Zsh-syntax-highlighting{{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
#}}}
# vim:foldmethod=marker:foldlevel=0
