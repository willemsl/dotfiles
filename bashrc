# This bashrc uses many lines of the bash-sensible project
# Check out this awesome project: https://github.com/mrzool/bash-sensible/blob/master/sensible.bash
# The rest is Ubuntu default or own preference

# If not running interactively, don't do anything
# and prevent failure on remote login (ssh)
case $- in
    *i*) ;;
      *) return;;
esac

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

# Update window size after every command
# prevent messing up the lineorder
shopt -s checkwinsize

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=3

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Medium size History
HISTSIZE=50000
HISTFILESIZE=10000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use german time format in history
HISTTIMEFORMAT="%d.%m.%y %T "

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: 
# http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it 
# regardless of the directory you're in
shopt -s cdable_vars

###########
# aliases #
###########

# enable color support of ls and also add handy aliases
# dircolors is an variable and can be overwritten 
# in the .dircolors file if it exists
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# reload bashrc quickly
alias rc='source ~/.bashrc'

# get cpu temp
if which sensors >/dev/null; then
alias cputemp='sensors | grep Core'
fi

# sane backward
alias ..='cd ..'
alias ...='cd ../../'

# handy ls shortcuts 
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Make some of the file manipulation programs verbose
alias mv='mv -v'
alias rm='rm -v'
alias cp='cp -v'

# Always make parent directory
alias mkdir='mkdir -pv'

# Limit ping to 5 requests
alias ping='ping -c 5'

# sudo on aliases
alias sudo='sudo '

# extract different archives automatically
# source: https://gist.github.com/rishid/6124223
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xvjf $1   ;;
      *.tar.gz)    tar xvzf $1   ;;
      *.bz2)       bunzip2 $1    ;;
      *.gz)        gunzip $1     ;;
      *.tar)       tar xf $1     ;;
      *.tbz2)      tar xjf $1    ;;
      *.tgz)       tar xzf $1    ;;
      *.zip)       unzip $1      ;;
      *.Z)         uncompress $1 ;;
      *.rar)       7z x $1       ;;
      *.7z)        7z x $1       ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

##############
# completion #
##############

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# enable git prompt if git is installed under ubuntu
if which git >/dev/null; then
     source /etc/bash_completion.d/git-prompt
     export GIT_PS1_SHOWDIRTYSTATE=1
     export GIT_PS1_SHOWUNTRACKEDFILES=1
     export GIT_PS1_SHOWUPSTREAM="auto"
     export PS1='\n\u@\h \w$(__git_ps1 " (%s)") \n\$ '
else
     export PS1='\n\u@\h \w\n\$ '
fi

# Use nvm
export NVM_DIR="./nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm, if installed
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if which npm >/dev/null; then
source <(npm completion)
fi




