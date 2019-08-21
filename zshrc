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
if [[ "$OSTYPE" == "darwin"* ]]; then
    plugins=(git ssh-agent)
else
    plugins=(git ssh-agent)
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
export DEFAULT_USER="neilryan"

setopt correct
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
if hash nvim 2> /dev/null; then
    alias vim="nvim"
fi
if hash htop 2> /dev/null; then
    alias top='htop'
fi
alias wiki='nvim -c VimwikiIndex -c "cd ~/All-Sync/research-wiki"'
export CWIKI_DIR="~/All-Sync/collection-wiki"
alias collection='nvim -c "cd $CWIKI_DIR" -c ":e index.md"'
#}}}
# Functions {{{
function countdown(){
   date1=$((`date +%s` + $1));
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
else
    if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte-2.91.sh
    fi
    export PATH=$PATH:/snap/bin
fi
export PATH=$PATH:~/.local/bin

if [[ "$HOST" == "xor.cs.washington.edu" ]]; then
    export PATH="/home/neilryan/local/bin:/home/neilryan/.local/bin:$PATH"
    export PATH="/mnt/bsg/diskbits/neilryan/pypy/bin:$PATH"
    export PATH="$PATH:/mnt/bsg/diskbits/neilryan/bsg/bsg_manycore/software/riscv-tools/riscv-install/bin"
    export PATH="$PATH:/mnt/bsg/diskbits/neilryan/llvm/llvm-install/bin"
    export BSG_IP_CORES_DIR="/mnt/bsg/diskbits/neilryan/bsg/basejump_stl"

    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/home/neilryan/local/lib"
    export PYTHONUNBUFFERED=1
    alias vim=nvim
fi
# }}}
# Zsh-syntax-highlighting{{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
#}}}
# vim:foldmethod=marker:foldlevel=0
