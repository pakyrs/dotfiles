# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
# make sure it shows the full name instead of just ~ in the taskbar - helps with wmctrl

# Workaround to work with Fish and Bash - posix and non posix
#argv=("$@")
## PROMPT
PS1='%F{#FF5555}%#%f(%B%F{#FF79C6}%n%f%b@%B%F{#BD93F9}%m%f%b)-[%B%F{#50FA7B}%~%f%b]-%F{#FF5555}%?%f
'
# Quickemu
export PATH="$HOME/scripts/quickemu:$PATH"
# EDITORS - nvim for all
export EDITOR=nvim
export VISUAL=$EDITOR
export SYSTEMD_EDITOR=$EDITOR
export TERM=xterm-256color
# Language settings
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"

## Functions
#if [[ "$hostname" == "zoidberg" || "$hostname" == "bender" || "$hostname" == "zapp" || "$hostname" == "kif" ]]; then
#    # If the hostname matches, execute the code in ~/.functions
#    if [ -f ~/.functions ]; then
#        . ~/.functions
#    fi
#fi
#

[ -f "$HOME/.functions" ] && source "$HOME/.functions"
# ALIASES
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"

# enable tabbing of hidden folders and files
setopt glob_dots


# DRACULA Manpager
export MANPAGER="/usr/bin/less -s -M +Gg"       #standard linux
#export MANPAGER="/opt/homebrew/bin/less -s -M +Gg" #M1 macOS
#man-page colors
        export LESS_TERMCAP_mb=$'\e[1;31m'      # begin bold
        export LESS_TERMCAP_md=$'\e[1;34m'      # begin blink
        export LESS_TERMCAP_so=$'\e[01;45;37m'  # begin reverse video
        export LESS_TERMCAP_us=$'\e[01;36m'     # begin underline
        export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
        export LESS_TERMCAP_se=$'\e[0m'         # reset reverse video
        export LESS_TERMCAP_ue=$'\e[0m'         # reset underline
        export GROFF_NO_SGR=1                   # for konsole

# DRACULA THEME FOR ZSH SYNTAX HIGHLIGHTING
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
# Main highlighter styling: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
ZSH_HIGHLIGHT_STYLES[comment]='fg=#6272A4'
ZSH_HIGHLIGHT_STYLES[alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[function]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[command]='fg=#50FA7B'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#50FA7B,italic'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#FFB86C,italic'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#FFB86C'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#BD93F9'
## Keywords
## Built ins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#8BE9FD'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=#8BE9FD'
## Punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#FF79C6'
## Serializable / Configuration Languages
## Storage
## Strings
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#F1FA8C'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#F1FA8C'
## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#F8F8F2'
## No category relevant in spec
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[path]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#FF79C6'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#BD93F9'
#ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[command-substitution-unquoted]='fg=?'
#ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=?'
#ZSH_HIGHLIGHT_STYLES[arithmetic-expansion]='fg=?'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=#FF5555'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[default]='fg=#F8F8F2'
ZSH_HIGHLIGHT_STYLES[cursor]='standout'

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula/dracula"

#### exa - Color Scheme Definitions Dracula Theme
#### ------------------------------

export EXA_COLORS="\
uu=36:\
gu=37:\
sn=32:\
sb=32:\
da=34:\
ur=34:\
uw=35:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36:"


#fastfetch
#python3 ~/sync/scripts/check_and_pull/check_and_pull.py

# PLUGINS
export ZSH=$HOME/.zsh
# prompt
source "$ZSH/spaceship/spaceship.zsh"
# highlights
source "$ZSH/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
# autosuggestions
source "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh"
# ZSH Completions
fpath=($ZSH/zsh-completions/src $fpath)
## autoload compinit
autoload -U compinit; compinit


check_git_repo_status_and_sync() {
    # grab latest remote changes
    yadm fetch --depth 1
    # compare the status
    local_status=$(yadm status -uno)

    if [[ $local_status == *"behind"* ]]; then
        echo "Your branch is behind the remote branch, pulling changes..."
            yadm pull
    elif [[ $local_status =~ (modified|added) ]]; then
        echo "Your branch is ahead of the remote branch. Consider pushing your changes."
        # Prompt for push
        read "response? Do you want to push changes? (y/n): "
        if [[ $response =~ ^[Yy]$ ]]; then
            yadm add -u && yadm commit -m "from $HOSTNAME" && yadm push -f origin master
        fi
    else
        echo "Your branch is up-to-date with the remote branch."
    fi
}
# add function call
#check_git_repo_status_and_sync

# Define a function to ask for user input
prompt_git_update_function() {
    read -r "?Do you want to check dotfiles updates? [Y/n] " response
    case $response in
        [Yy]*)
            check_git_repo_status_and_sync;;
        *)
            echo "dotfile check skipped...";;
    esac
}

# ask
prompt_git_update_function
