# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ -s "$HOME/.bash_colors" ]] && . "$HOME/.bash_colors"

##########################
# Git env vars
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=auto

export IRBRC=$HOME/.irbrc
export CDPATH=$CDPATH:$HOME/workspace
export STANDALONE_PATH="$HOME/standalone"
export ANDROID_HOME="$STANDALONE_PATH/Android"

# Paths
export PATH="./.bundle/binstubs:$PATH"                      # gems bins from local folder
export PATH="./.bundle/bin:$PATH"                           # gems bins from local folder
export PATH="./node_modules/.bin:$PATH"                     # node bins from local folder
export PATH="$HOME/.rvm/bin:$PATH"                          # rvm
export PATH="$HOME/.rbenv/bin:$PATH"                        # rbenv
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"     # rbenv ruby-build
export PATH="$HOME/.pyenv/bin:$PATH"                        # pyenv
export PATH="$HOME/.composer:$PATH"                         # composer
export PATH="$HOME/.arc/arcanist/bin/:$PATH"                # arcanist
export PATH="$ANDROID_HOME/platform-tools/:$PATH"           # android-sdk
export PATH="$ANDROID_HOME/tools/:$PATH"                    # android-sdk
export PATH="$STANDALONE_PATH/android-studio/bin/:$PATH"    # android-studio
export PATH="$STANDALONE_PATH/genymotion/:$PATH"            # genymotion
export PATH="/usr/local/heroku/bin:$PATH"                   # Heroku Toolbelt
export PATH="$PATH:`yarn global bin`"                       # Yarn global bin


# rbenv
# eval "$(rbenv init -)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

# pyenv init to enable shims and autocompletion
# eval "$(pyenv init -)"

USER_AT_HOST="\u@\h"
if [[ $UID -ne 0 ]]; then
  WORKING_DIR="${BRIGHT_YELLOW}\w${RESET}"
else
  WORKING_DIR="${BRIGHT_RED}\w${RESET}"
fi

# GIT='$(__git_ps1 "[ %s ]")'exec $SHELL
# export PS1="${USER_AT_HOST}:${WORKING_DIR} ${GIT}\n$ "

RVM_GIT='($($rvm_bin_path/rvm-prompt)) $(__git_ps1 "[ %s ]")'
export PS1="${USER_AT_HOST}:${WORKING_DIR} ${RVM_GIT}\n$ "

# Standalone applications
alias franz="$STANDALONE_PATH/Franz/Franz"
alias ngrok="$STANDALONE_PATH/ngrok"
alias popcorntime="$STANDALONE_PATH/Popcorn-Time/Popcorn-Time"
alias redis="$STANDALONE_PATH/redis/src/redis-server"
alias stremio="$STANDALONE_PATH/stremio/Stremio.sh"

# Wordpress MVC alias
alias wpmvc="WPMVC_WORDPRESS_PATH=./htdocs/wordpress/ ./htdocs/wp-content/plugins/wp-mvc/wpmvc"
