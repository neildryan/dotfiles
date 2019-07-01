[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return
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
ZSH_THEME="avit"
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
# TODO ADD gitfast
if [[ "$OSTYPE" == "darwin"* ]]; then
    plugins=(git ssh-agent colorize colored-man-pages cp)
else
    plugins=(git ssh-agent colorize colored-man-pages)
fi
source $ZSH/oh-my-zsh.sh
#}}}
# User added config {{{
setopt correct
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# }}}
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
if hash bat 2> /dev/null; then
    alias cat='bat'
fi
if hash prettyping 2> /dev/null; then
    alias ping='prettyping --nolegend'
fi
alias emacs="/usr/local/Cellar/emacs-plus/26.2/bin/emacs"
#}}}
# Zsh-syntax-highlighting{{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
#}}}
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
# vim:foldmethod=marker:foldlevel=0
