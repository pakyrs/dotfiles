# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#              _   _       
#   _ __  __ _| |_| |_  ___
#  | '_ \/ _` |  _| ' \(_-<
#  | .__/\__,_|\__|_||_/__/
#  |_|                     
#  
#  
# macos options to include brew paths
if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
#  __ ____ _ _ _ ___
#  \ V / _` | '_(_-<
#   \_/\__,_|_| /__/
#                   
export PATH="$HOME/scripts/quickemu:/opt/nvim-linux64/bin:$PATH"
export EDITOR=nvim
export VISUAL=$EDITOR
export SYSTEMD_EDITOR=$EDITOR
export TERM=xterm-256color
# Language settings
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
# enable tabbing of hidden folders and files
setopt glob_dots
#      _      _ _   
#   __(_)_ _ (_) |_ 
#  |_ / | ' \| |  _|
#  /__|_|_||_|_|\__|
#                   
# Where is zinit going to live? 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# ZINIT - PLUGINS - load under /lua/plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
#zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# Add in Powerlevel10k - PROMPT
zinit ice depth=1; zinit light romkatv/powerlevel10k

# ZINIT - SNIPPETS - to get OhMyZSH plugins https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::debian
zinit snippet OMZP::docker-compose
zinit snippet OMZP::docker
zinit snippet OMZP::mosh
zinit snippet OMZP::ssh-agent
zinit snippet OMZP::command-not-found
# zinit snippet OMZP::colored-man-pages # not needed

# COMPLETION STYLING
## match case insensitive completion, ie d to match Downloads
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
## colored ls
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
## preview pane for fzf
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
# Load completions
autoload -Uz compinit; compinit
## replay all cached completions
zinit cdreplay -q
  
#   _    _    _                
#  | |_ (_)__| |_ ___ _ _ _  _ 
#  | ' \| (_-<  _/ _ \ '_| || |
#  |_||_|_/__/\__\___/_|  \_, |
#                         |__/ 
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
## erase any duplicate inside histfile
HISTDUP=erase
## append any command to hist file
setopt appendhistory
## share history across shells
setopt sharehistory
## ignore writing commands that start with space to histfile, good for sensitive info
setopt hist_ignore_space
## prevent any duplicate command to be saved in our history
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
## prevent duplicate to be shown in the search
setopt hist_find_no_dups

#        _ _                 
#   __ _| (_)__ _ ___ ___ ___
#  / _` | | / _` (_-</ -_|_-<
#  \__,_|_|_\__,_/__/\___/__/
#                            
#  
[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
# EZA / EXA shell integration
set_aliases() {
  alias ls='eza -Sh --icons --color=always --group-directories-first'
  alias ll='eza -lah --icons --color=always --group-directories-first'
}

if [[ "$OSTYPE" == "darwin"* ]]; then
  set_aliases
# Debian stable lacks the new eza
elif [[ -f /etc/debian_version ]]; then
  alias ls='exa -Sh --icons --color=always --group-directories-first'
  alias ll='exa -lah --icons --color=always --group-directories-first'
else
  if [[ -f /etc/fedora-release || -f /etc/SuSE-release || -f /etc/SUSE-brand || "$(uname -o)" == "Android" ]]; then
    set_aliases
  fi
fi
#    __              _   _             
#   / _|_  _ _ _  __| |_(_)___ _ _  ___
#  |  _| || | ' \/ _|  _| / _ \ ' \(_-<
#  |_|  \_,_|_||_\__|\__|_\___/_||_/__/
#  
[ -f "$HOME/.functions" ] && source "$HOME/.functions"
#  
#   _   _                     
#  | |_| |_  ___ _ __  ___ ___
#  |  _| ' \/ -_) '  \/ -_|_-<
#   \__|_||_\___|_|_|_\___/__/
#                             
#
#### BAT / BATCAT
export BAT_THEME="Dracula"
#### EXA - Color Scheme Definitions Dracula Theme
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
#### EZA - Color Scheme Definitions Dracula Theme
export EZA_COLORS="\
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

# DRACULA Manpager - ANSI16 color palette
export MANPAGER="/usr/bin/less -s -M +Gg"       #standard linux
#export MANPAGER="/opt/homebrew/bin/less -s -M +Gg" #M1 macOS
        export LESS_TERMCAP_mb=$'\e[1;31m'      # begin bold
        export LESS_TERMCAP_md=$'\e[1;92m'      # begin blink (Green)
        export LESS_TERMCAP_so=$'\e[01;45;37m'  # begin reverse video
        export LESS_TERMCAP_us=$'\e[01;93m'     # begin underline (Pink)
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

#      _        _ _   _     _                     _   _             
#   __| |_  ___| | | (_)_ _| |_ ___ __ _ _ _ __ _| |_(_)___ _ _  ___
#  (_-< ' \/ -_) | | | | ' \  _/ -_) _` | '_/ _` |  _| / _ \ ' \(_-<
#  /__/_||_\___|_|_| |_|_||_\__\___\__, |_| \__,_|\__|_\___/_||_/__/
#                                  |___/                            
#  
# FZF - shell integration
if [[ "$OSTYPE" == "darwin"* ]] || [[ "$(uname -o)" == "Android" ]]; then
  # macOS or termux - fzf > 0.44
  source <(fzf --zsh)
elif [[ -f /etc/debian_version ]]; then
  # Debian
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
elif [[ -f /etc/fedora-release ]]; then
  # Fedora
  source /usr/share/fzf/shell/key-bindings.zsh
elif [[ -f /etc/SuSE-release || -f /etc/SUSE-brand ]]; then
  # SUSE
  source /etc/zsh_completion.d/fzf-key-bindings
fi

# ZOXIDE - load if the version installed is at least 0.9
ZOX_VER=$(zoxide --version | grep -oE '[0-9]+\.[0-9]+') # normalize output
if (( $(echo "$ZOX_VER >= 0.9" | bc -l) )); then
    eval "$(zoxide init --cmd cd zsh)"
else
    : #nothing
fi

# PowerLevel10k, needs to be at the end
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
