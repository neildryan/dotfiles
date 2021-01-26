# Overview:
# * Currently uses p10k as zsh theme, though `Typewritten` is also good and
#   more minimal
# * After removing oh-my-zsh, added git aliases & ssh-agent plugins in here
#
# TODO zsh-completions probably does the oh-my-zsh completion thing

bindkey -e # Use readline, even when in vim terminal
echo "don't panic" \\u001b\[36m█\\u001b\[35m█\\u001b\[37m█\\u001b\[35m█\\u001b\[36m█
# Typewritten {{{
fpath+="$HOME/.files/typewritten"
autoload -U promptinit; promptinit
prompt typewritten

# # }}}
# Other ZSH config {{{
# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

HIST_STAMPS="mm/dd/yyyy"
#}}}
# Oh-my-zsh dumping ground {{{
# Get colors on tab completion
export CLICOLOR=1
# BSD_LSCOLORS and Linux LS_COLORS (they're the same)
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
autoload -Uz compinit
compinit
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# TODO This alias only works on OSX, need a different one for linux
ls -G . &>/dev/null && alias ls='ls -G'

setopt auto_menu
setopt complete_in_word
setopt always_to_end
zmodload zsh/complist
zstyle ':completion:*:*:*:*:*' menu select
# Case sensitive, hypen sensitive
zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
# Complete . and .. special directories
zstyle ':completion:*' special-dirs true
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion:*' use-cache yes
setopt auto_cd
setopt multios
setopt prompt_subst

if command diff --color . . &>/dev/null; then
  alias diff='diff --color'
fi

# Changing/making/removing directory
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
# }}}
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

alias ll="ls -lh"
alias la='ls -lAh'
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

alias r2="r2 -A"
alias python="python3"
alias pip="pip3"
alias wiki='vim -c "WikiIndex"'

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
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
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
# vim:foldmethod=marker:foldlevel=0
