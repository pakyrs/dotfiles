# -- VARIABLES ----------------------------------------------------------
export TERM=xterm-256color
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Workaround to work with Fish and Bash - posix and non posix
argv=("$@")

# prevent GPG from being confused on where to read input from
export GPG_TTY=$(tty)

# -- ALIASES ------------------------------------------------------------
if [ -f ~/.aliases ]; then
    . ~/.aliases
fi

# -- FUNCTIONS ----------------------------------------------------------
if [[ "$hostname" == "zoidberg" || "$hostname" == "bender" || "$hostname" == "zapp" ]]; then
    # If the hostname matches, execute the code in ~/.functions
    if [ -f ~/.functions ]; then
        . ~/.functions
    fi
fi

# -- PROMPT --------------------------------------------------------------
if [ "$HOSTNAME" == "docker" ]; then
        # set the Docker theme
        PS1='🐳  \[\033[1;36m\]\h \[\033[1;34m\]\W\[\033[0;35m\] \[\033[1;36m\]'
        alias vpncheck='python3 /STORAGE/docker/vpn-jackett-qbit/vpncheck.py'
        cd /STORAGE/docker
        vpncheck
    else
        # WIT THEME
       # PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PS1='\[\e[38;5;247;5m\]>\[\e[0;38;5;99;1m\]\$\[\e[0;38;5;252m\]_(\[\e[38;5;40m\]\u\[\e[38;5;252m\]@\[\e[38;5;205;1m\]\h\[\e[0;38;5;252m\])-[\[\e[38;5;99;3m\]\w\[\e[0;38;5;252m\]]-\[\e[38;5;244m\]$?\n\[\e[0m\]'
fi

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

source /etc/grc.bash
# FZF history
source /usr/share/doc/fzf/examples/key-bindings.bash
source /usr/share/doc/fzf/examples/completion.bash

