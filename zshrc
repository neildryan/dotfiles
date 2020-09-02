# Path to your oh-my-zsh installation. {{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    export ZSH=/Users/neilryan/.oh-my-zsh
else
    export ZSH=/home/$USER/.oh-my-zsh
fi
#}}}
# Theme {{{
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
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
#}}}
# Oh-my-zsh config {{{
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
plugins=(git ssh-agent)
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
export DEFAULT_USER=$USER

setopt correct
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#}}}
# Aliases {{{
# For a full list of active aliases, run `alias`.
bindkey -r "^o"
bindkey -r "^l"
bindkey "^o" clear-screen

alias r2="r2 -A"
alias python="python3"
if [[ "$OSTYPE" != "darwin"* ]]; then
    alias open='xdg-open'
fi
if hash nvim 2> /dev/null; then
    alias vim="nvim"
fi
if hash htop 2> /dev/null; then
    alias top='htop'
fi
alias toce='cd ~/Documents/toce2020 && nvim -S "Session.vim"'
#}}}
# Functions {{{
function timer(){
    secs=$(($1 * 60))
    if [[ "$OSTYPE" == "darwin"* ]]; then  #OSX, do one for linux later
        caffeinate -u -t $secs &
    fi
    date1=$((`date +%s` + ($1 * 60)));
    while [ "$date1" -ge `date +%s` ]; do
        echo -ne "$(date -ju -f %s $(($date1 - $(date +%s))) +%H:%M:%S)\r"
        sleep 1
    done
}
function stopwatch(){
    date1=`date +%s`;
    while true; do
        echo -ne "$(date -ju -f %s $(($(date +%s) - $date1)) +%H:%M:%S)\r";
        sleep 1
    done
}
# }}}
# Path changes{{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    export PATH=$PATH:~/Library/Python/3.7/bin
    export PATH=$PATH:/usr/local/sbin
else
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
    fi
    export PATH=$PATH:/snap/bin
fi
if [ -d "$HOME/lineage/platform-tools" ] ; then
    export PATH="$PATH:$HOME/lineage/platform-tools"
fi
export PATH=$PATH:~/.local/bin
# }}}
# Zsh-syntax-highlighting{{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
#}}}
echo "don't panic" \\u001b\[36m█\\u001b\[35m█\\u001b\[37m█\\u001b\[35m█\\u001b\[36m█
# vim:foldmethod=marker:foldlevel=0
