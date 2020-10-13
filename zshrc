# Overview:
# * Currently uses p10k as zsh theme, though `Typewritten` is also good and
#   more minimal
# * After removing oh-my-zsh, added git aliases & ssh-agent plugins in here
#
# TODO zsh-completions probably does the oh-my-zsh completion thing

echo "don't panic" \\u001b\[36m█\\u001b\[35m█\\u001b\[37m█\\u001b\[35m█\\u001b\[36m█
# Powerline10k init {{{
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.files/powerlevel10k/powerlevel10k.zsh-theme
#}}}
# # Typewritten {{{
# fpath+="$HOME/.files/typewritten"
# autoload -U promptinit; promptinit
# prompt typewritten

# # }}}
# Other ZSH config {{{
# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
UPDATE_ZSH_DAYS=7

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

alias r2="r2 -A"
alias python="python3"
alias ls="ls -G"
alias ll="ls -l"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
if [[ "$OSTYPE" != "darwin"* ]]; then
    alias open='xdg-open'
fi
if hash nvim 2> /dev/null; then
    alias vim="nvim"
fi
if hash htop 2> /dev/null; then
    alias top='htop'
fi
# Git Aliases (from oh-my-zsh git plugin) {{{
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcam='git commit -am'
alias gco='git checkout'
alias gcm='git checkout master'
alias gd='git diff'
alias gl='git pull'
alias glg='git log --stat'
alias glo='git log --oneline --decorate'
alias gp='git push'
alias gst='git status'
# }}}
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
# ssh-agent -- from oh-my-zsh {{{
typeset _agent_forwarding _ssh_env_cache

function _start_agent() {
	local lifetime
	zstyle -s :omz:plugins:ssh-agent lifetime lifetime

	# start ssh-agent and setup environment
	echo Starting ssh-agent...
	ssh-agent -s ${lifetime:+-t} ${lifetime} | sed 's/^echo/#echo/' >! $_ssh_env_cache
	chmod 600 $_ssh_env_cache
	. $_ssh_env_cache > /dev/null
}

function _add_identities() {
	local id line sig lines
	local -a identities loaded_sigs loaded_ids not_loaded
	zstyle -a :omz:plugins:ssh-agent identities identities

	# check for .ssh folder presence
	if [[ ! -d $HOME/.ssh ]]; then
		return
	fi

	# add default keys if no identities were set up via zstyle
	# this is to mimic the call to ssh-add with no identities
	if [[ ${#identities} -eq 0 ]]; then
		# key list found on `ssh-add` man page's DESCRIPTION section
		for id in id_rsa id_dsa id_ecdsa id_ed25519 identity; do
			# check if file exists
			[[ -f "$HOME/.ssh/$id" ]] && identities+=$id
		done
	fi

	# get list of loaded identities' signatures and filenames
	if lines=$(ssh-add -l); then
		for line in ${(f)lines}; do
			loaded_sigs+=${${(z)line}[2]}
			loaded_ids+=${${(z)line}[3]}
		done
	fi

	# add identities if not already loaded
	for id in $identities; do
		# check for filename match, otherwise try for signature match
		if [[ ${loaded_ids[(I)$HOME/.ssh/$id]} -le 0 ]]; then
			sig="$(ssh-keygen -lf "$HOME/.ssh/$id" | awk '{print $2}')"
			[[ ${loaded_sigs[(I)$sig]} -le 0 ]] && not_loaded+="$HOME/.ssh/$id"
		fi
	done

	[[ -n "$not_loaded" ]] && ssh-add ${^not_loaded}
}

# Get the filename to store/lookup the environment from
_ssh_env_cache="$HOME/.ssh/environment-$SHORT_HOST"

# test if agent-forwarding is enabled
zstyle -b :omz:plugins:ssh-agent agent-forwarding _agent_forwarding

if [[ $_agent_forwarding == "yes" && -n "$SSH_AUTH_SOCK" ]]; then
	# Add a nifty symlink for screen/tmux if agent forwarding
	[[ -L $SSH_AUTH_SOCK ]] || ln -sf "$SSH_AUTH_SOCK" /tmp/ssh-agent-$USER-screen
elif [[ -f "$_ssh_env_cache" ]]; then
	# Source SSH settings, if applicable
	. $_ssh_env_cache > /dev/null
	if [[ $USER == "root" ]]; then
		FILTER="ax"
	else
		FILTER="x"
	fi
	ps $FILTER | grep ssh-agent | grep -q $SSH_AGENT_PID || {
		_start_agent
	}
else
	_start_agent
fi

_add_identities

# tidy up after ourselves
unset _agent_forwarding _ssh_env_cache
unfunction _start_agent _add_identities
#}}}
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
export XDG_DATA_HOME="$HOME/.config"
export XDG_CONFIG_HOME="$HOME/.config"
# }}}
# Zsh-syntax-highlighting{{{
if [[ "$OSTYPE" == "darwin"* ]]; then
    source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
    source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
#}}}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.files/p10k.zsh ]] || source ~/.files/p10k.zsh
# vim:foldmethod=marker:foldlevel=0
