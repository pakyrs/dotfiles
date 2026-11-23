# ==============================================================================
#  ~/.zshrc
# ==============================================================================
#
#  HOW TO READ KEY NOTATION IN THIS FILE
#  -------------------------------------
#   Ctrl+X, then l   ->  hold Ctrl, press X, let go of both, then press l
#   Ctrl+X Ctrl+E    ->  hold Ctrl, press X, then E (keep Ctrl held the whole time)
#   Esc, Esc         ->  press Esc twice
#   In bindkey lines: ^X = Ctrl+X   \e = Esc   \C-b = Ctrl+B   \n = Enter
#
#  KEY CHEAT SHEET (everything this file sets up)
#  ----------------------------------------------
#   Tab                complete (fuzzy finder: type to filter, Enter to pick)
#   Right arrow / End  accept the grey autosuggestion
#   Ctrl+Space         accept the grey autosuggestion
#   Alt+F              accept the next word of the autosuggestion
#   Ctrl+X Ctrl+E      edit the current command in nvim (save + quit to return)
#   Ctrl+_  /  Ctrl+/  undo last edit on the command line
#   Ctrl+X Ctrl+_      redo
#   Ctrl+X, then l     clear screen + scrollback, keep what you're typing
#   Ctrl+X, then c     copy the current command to the clipboard
#   Esc, Esc           put "sudo " in front of the current command
#   Ctrl+X, then gc    insert: git commit -m ""          (cursor in quotes)
#   Ctrl+X, then ga    insert: git add -A && git commit -m ""
#   Ctrl+X, then gp    RUN:    git push
#   Ctrl+X, then dc    RUN:    docker compose up -d
#   Ctrl+X, then fd    insert: fd <pattern> | fzf        (cursor at pattern)
#
#  USEFUL BUILT-IN ZSH KEYS (work without any config)
#  --------------------------------------------------
#   Ctrl+A / Ctrl+E    jump to start / end of line
#   Alt+B  / Alt+F     jump back / forward one word
#   Ctrl+W             delete previous word        (undo with Ctrl+_)
#   Ctrl+U             delete the whole line
#   Ctrl+K             delete from cursor to end of line
#   Ctrl+R             search command history
#   Ctrl+L             clear screen (keeps what you're typing)
#   Ctrl+C             cancel the current line
#
#  LIST ALL SHORTCUTS:   bindkey | grep '\^X'
#  AFTER EDITING:        zsh -n ~/.zshrc && source ~/.zshrc
#  UPDATE PLUGINS:       for p in ~/.zsh/plugins/*; do git -C "$p" pull; done
#
#  SECTIONS
#   1. Environment variables        8. Hooks (on cd)
#   2. OS detection                 9. Aliases: regular
#   3. Shell options & history     10. Aliases: suffix
#   4. Completion                  11. Aliases: global
#   5. Key bindings (built-in)     12. zmv (batch rename)
#   6. Custom widgets              13. Named directories
#   7. Snippet hotkeys             14. Plugins, prompt & tools (keep last)
#
# ==============================================================================


# ------------------------------------------------------------------------------
# 1. ENVIRONMENT VARIABLES
# ------------------------------------------------------------------------------

# Default editor: used by Ctrl+X Ctrl+E and the code-file suffix aliases
export EDITOR=nvim
export VISUAL=nvim

# Personal scripts and symlinks (e.g. fd -> fdfind on Ubuntu)
export PATH="$HOME/.local/bin:$PATH"

# ripgrep reads its default flags from this file
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Where the plugins in sections 4 and 14 are cloned
ZSH_PLUGINS="$HOME/.zsh/plugins"


# ------------------------------------------------------------------------------
# 2. OS DETECTION
# ------------------------------------------------------------------------------
# Picks the right commands so everything below works on macOS and Linux.
#   _open_cmd  -> opens a file in the default app
#   _clip_cmd  -> copies to the clipboard
#   _ls_color  -> turns on colours for ls
# Must stay ABOVE sections 6, 8, 9, 10 and 11, which use these.

if [[ "$OSTYPE" == darwin* ]]; then
  _open_cmd='open'
  _clip_cmd='pbcopy'
  _ls_color='-G'
else
  _open_cmd='xdg-open'
  if [[ -n "$WAYLAND_DISPLAY" ]]; then
    _clip_cmd='wl-copy'                        # Wayland (install: wl-clipboard)
  else
    _clip_cmd='xclip -selection clipboard'     # X11 (install: xclip)
  fi
  _ls_color='--color=auto'
fi


# ------------------------------------------------------------------------------
# 3. SHELL OPTIONS & HISTORY
# ------------------------------------------------------------------------------

# HISTORY: saved to ~/.zsh_history and shared between open terminals
#   PRESS: Ctrl+R to search it,  Up arrow to step back through it
#   TYPE:  a space before a command to keep it OUT of history (e.g. secrets)
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # all terminals see each other's commands
setopt HIST_IGNORE_ALL_DUPS   # no duplicate entries
setopt HIST_IGNORE_SPACE      # leading space = not saved
setopt HIST_REDUCE_BLANKS     # tidy extra spaces

# HISTORY EXPANSION SAFETY
#   TYPE:  sudo !!      then PRESS: Enter
#   The prompt shows the real command (e.g. sudo apt update) instead of running it.
#   PRESS: Enter again to actually run it.
#   Other expansions:  !$ = last argument   !* = all arguments   !git = last git command
setopt HIST_VERIFY

# Your own completion files (kubectx, kubens, ...), must come before compinit
fpath=(~/.zsh/completions $fpath)

# ------------------------------------------------------------------------------
# 4. COMPLETION
# ------------------------------------------------------------------------------
#   PRESS: Tab        -> fuzzy finder of matches: type to filter, Enter to pick
#                        (commands, files, folders, git branches, flags...)
#   Case-insensitive: "doc" + Tab finds "Documents"
#   If fzf or fzf-tab isn't installed, Tab falls back to an arrow-key menu.
#   Completions acting strange?  TYPE: rm -f ~/.zcompdump*; exec zsh

# Extra completion definitions (docker, npm, etc.), must come before compinit
[[ -d $ZSH_PLUGINS/zsh-completions/src ]] && fpath=($ZSH_PLUGINS/zsh-completions/src $fpath)

autoload -Uz compinit
compinit

zmodload zsh/complist
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'     # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"    # colours like ls
zstyle ':completion:*:descriptions' format '[%d]'          # group headings

# FZF-TAB: Tab opens a fuzzy finder (needs fzf). Must load after compinit
# and before autosuggestions / syntax highlighting (section 14).
if command -v fzf >/dev/null && [[ -f $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh ]]; then
  zstyle ':completion:*' menu no
  source $ZSH_PLUGINS/fzf-tab/fzf-tab.plugin.zsh
else
  zstyle ':completion:*' menu select                       # fallback: arrow-key menu
fi

# KUBECTL / HELM COMPLETION (must be after compinit)
#   TYPE: k logs   then PRESS: Tab  -> fuzzy-pick a pod
#   TYPE: k get    then PRESS: Tab  -> pick a resource type
if command -v kubectl >/dev/null; then
  source <(kubectl completion zsh)
fi
if command -v helm >/dev/null; then
  source <(helm completion zsh)
fi

# ------------------------------------------------------------------------------
# 5. KEY BINDINGS (built-in widgets)
# ------------------------------------------------------------------------------

# EDIT COMMAND IN EDITOR
#   PRESS: Ctrl+X Ctrl+E
#   Opens what you've typed in nvim. Fix it, then :wq to put it back on the prompt.
#   Then PRESS: Enter to run it.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^X^E' edit-command-line

# UNDO
#   PRESS: Ctrl+_  (Ctrl+Shift+minus)  or  Ctrl+/  in most terminals
#   Built in, no config needed. Great after Ctrl+W deletes too much.

# REDO
#   PRESS: Ctrl+X Ctrl+_
bindkey '^X^_' redo

# MAGIC SPACE (disabled, HIST_VERIFY in section 3 is used instead)
#   If enabled: TYPE: sudo !!  then PRESS: Space  -> expands instantly.
#   Uncomment the line below to use it.
# bindkey ' ' magic-space


# ------------------------------------------------------------------------------
# 6. CUSTOM WIDGETS (your own command-line actions)
# ------------------------------------------------------------------------------
# A widget = function (does the work) + zle -N (registers it) + bindkey (key).
# Inside a widget: $BUFFER = the whole command line, $CURSOR = cursor position.

# CLEAR SCREEN, KEEP YOUR COMMAND
#   PRESS: Ctrl+X, then l
#   Clears the screen AND scrollback, but keeps what you're typing on the prompt.
clear-keep-buffer() {
  printf '\e[3J'        # clear scrollback
  zle clear-screen      # clear screen, redraw prompt with your command intact
}
zle -N clear-keep-buffer
bindkey '^Xl' clear-keep-buffer

# COPY CURRENT COMMAND TO CLIPBOARD
#   PRESS: Ctrl+X, then c
#   Shows "Copied to clipboard" under the prompt. Paste anywhere.
#   (Ctrl+X Ctrl+C can't be used: the terminal treats Ctrl+C as "cancel".)
#   ${=_clip_cmd} splits "xclip -selection clipboard" into command + arguments.
copy-buffer() {
  print -rn -- "$BUFFER" | ${=_clip_cmd}
  zle -M "Copied to clipboard"
}
zle -N copy-buffer
bindkey '^Xc' copy-buffer

# ADD SUDO IN FRONT
#   PRESS: Esc, Esc
#   apt update  ->  sudo apt update   (never adds sudo twice)
#   Tip: PRESS Up arrow to recall a "permission denied" command, then Esc, Esc.
prepend-sudo() {
  [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
  CURSOR=${#BUFFER}
}
zle -N prepend-sudo
bindkey '\e\e' prepend-sudo


# ------------------------------------------------------------------------------
# 7. SNIPPET HOTKEYS (insert a command for you)
# ------------------------------------------------------------------------------
# All are: PRESS Ctrl+X, let go, then type the two letters.
# Format:  bindkey -s '<keys>' '<text to insert>'
#   \C-b = move cursor one character left (add one per character)
#   \n   = press Enter, so the command RUNS IMMEDIATELY
# Make your own, e.g.:  bindkey -s '^Xgo' 'git checkout '

# PRESS: Ctrl+X, then gc  ->  git commit -m "|"   (cursor in quotes: type message, Enter)
bindkey -s '^Xgc' 'git commit -m ""\C-b'

# PRESS: Ctrl+X, then ga  ->  git add -A && git commit -m "|"
bindkey -s '^Xga' 'git add -A && git commit -m ""\C-b'

# PRESS: Ctrl+X, then gp  ->  RUNS git push immediately
bindkey -s '^Xgp' 'git push\n'

# PRESS: Ctrl+X, then dc  ->  RUNS docker compose up -d immediately
bindkey -s '^Xdc' 'docker compose up -d\n'

# PRESS: Ctrl+X, then fd  ->  fd _ | fzf   (_ = where the cursor lands)
#   Type a file-name pattern, PRESS Enter, then pick a result in fzf.
bindkey -s '^Xfd' 'fd  | fzf\C-b\C-b\C-b\C-b\C-b\C-b'


# ------------------------------------------------------------------------------
# 8. HOOKS (run automatically every time you change directory)
# ------------------------------------------------------------------------------
# No keys to press: these run on every cd (including zoxide jumps).
# add-zsh-hook lets several functions share the chpwd hook, and won't add
# the same one twice if you re-source this file.

autoload -Uz add-zsh-hook

# AUTO LS
#   After every cd, lists the folder. Skips the listing if there are over 50 items.
#   `command ls` bypasses the ls alias in section 9 so it stays a short list.
auto_ls() {
  local count=$(command ls -A | wc -l)
  if (( count <= 50 )); then
    command ls -A $_ls_color
  else
    echo "$count items (listing skipped)"
  fi
}
add-zsh-hook chpwd auto_ls

# AUTO PYTHON VENV
#   cd into a project with a .venv folder  -> activates it
#   cd out of the project                  -> deactivates it
auto_venv() {
  if [[ -z "$VIRTUAL_ENV" && -f .venv/bin/activate ]]; then
    source .venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" && "$PWD"/ != "${VIRTUAL_ENV:h}"/* ]]; then
    deactivate
  fi
}
add-zsh-hook chpwd auto_venv

# Hooks only fire on cd, so also check the folder a new terminal opens in
auto_venv


# ------------------------------------------------------------------------------
# 9. ALIASES: REGULAR
# ------------------------------------------------------------------------------

# TYPE: ls   -> long listing with colours
alias l="ls -ah $_ls_color"
alias ls="ls -lah $_ls_color"
alias vi="nvim"
alias vim="nvim"
# KUBERNETES
alias k='kubectl'
alias kgp='kubectl get pods'              # TYPE: kgp
alias kgs='kubectl get svc'               # TYPE: kgs
alias kgd='kubectl get deploy'            # TYPE: kgd
alias kd='kubectl describe'               # TYPE: kd pod my-pod
alias kl='kubectl logs -f'                # TYPE: kl my-pod        (follow logs)
alias kaf='kubectl apply -f'              # TYPE: kaf deploy.yaml
alias kdel='kubectl delete'               # TYPE: kdel pod my-pod
alias kctx='kubectx'                      # TYPE: kctx   -> pick a cluster
alias kns='kubens'                        # TYPE: kns    -> pick a namespace
alias kubectl='kubecolor'
compdef kubecolor=kubectl

# ------------------------------------------------------------------------------
# 10. ALIASES: SUFFIX (open a file just by typing its name)
# ------------------------------------------------------------------------------
# TYPE: the file name on its own, then PRESS: Enter
#   main.go       -> opens in nvim
#   package.json  -> opens in jless
#   README.md     -> opens in bat
# Only works when the file name is the FIRST word, so `cat file.json` still works.

# Code / config files -> editor
alias -s {go,rs,py,js,ts,tsx,lua,c,h,cpp,toml,yaml,yml}="$EDITOR"

# Viewers
alias -s json=jless     # interactive JSON viewer (q to quit)
alias -s md=bat         # syntax-highlighted viewer (Ubuntu: change to batcat)
alias -s log=less       # pager (q to quit)

# Default app for the OS (Finder/Preview on macOS, xdg-open on Linux)
alias -s {html,pdf,png,jpg,jpeg,gif}="$_open_cmd"


# ------------------------------------------------------------------------------
# 11. ALIASES: GLOBAL (type these anywhere in a command, usually at the end)
# ------------------------------------------------------------------------------
# UPPERCASE names so they never clash with real arguments.
# To see what one is set to:  print -r -- $galiases[C]
#   (typing `alias C` would itself get expanded!)

# Redirects
alias -g NE='2>/dev/null'        # TYPE: du -sh /* NE          -> hide errors
alias -g NO='>/dev/null'         # TYPE: make NO               -> hide normal output

# Pipes
alias -g J='| jq'                # TYPE: curl -s url J         -> pretty-print JSON
alias -g G='| grep'              # TYPE: history G docker      -> filter lines
alias -g L='| less'              # TYPE: git log L             -> page through output
alias -g H='| head'              # TYPE: ls H                  -> first 10 lines
alias -g C="| $_clip_cmd"        # TYPE: cat file.txt C        -> copy output to clipboard

# KUBERNETES
alias -g KY='-o yaml'                     # TYPE: k get deploy web KY
alias -g KW='-o wide'                     # TYPE: kgp KW              -> shows node + IP
alias -g KA='--all-namespaces'            # TYPE: kgp KA
alias -g DRY='--dry-run=client -o yaml'   # TYPE: k create deploy web --image=nginx DRY > web.yaml

# ------------------------------------------------------------------------------
# 12. ZMV (batch rename / move files with patterns)
# ------------------------------------------------------------------------------
# ALWAYS do a dry run first with -n, then run it for real.
#
#   TYPE: mmv *.log *.txt                quick rename, no quotes needed
#   TYPE: zmv -n '(*).log' '$1.txt'      dry run: shows what would change
#   TYPE: zmv '(*).log' '$1.txt'         do it ($1 = text matched by (*))
#   TYPE: zmv -i '(*).log' '$1.txt'      ask y/n for each file
#   TYPE: zmv '(*)' '${(L)1}'            make all names lowercase
#   TYPE: zmv '* *' '${f// /_}'          replace spaces with underscores
#   TYPE: zcp '(*).conf' '$1.conf.bak'   batch copy (e.g. backups)
#
# Flags:  -n dry run   -i confirm each   -v show each action

autoload -Uz zmv
alias mmv='noglob zmv -W'        # wildcard style: mmv *.jpeg *.jpg
alias zcp='zmv -C'               # batch copy
alias zln='zmv -L'               # batch symlink


# ------------------------------------------------------------------------------
# 13. NAMED DIRECTORIES (bookmarks: use as ~name)
# ------------------------------------------------------------------------------
#   TYPE: cd ~dots           go to ~/dotfiles
#   TYPE: cp file.pdf ~dl/   use in any command
#   TYPE: hash -d            list all bookmarks
# Add your own:  hash -d name=/path/to/folder

hash -d dots=~/dotfiles
hash -d dl=~/Downloads
hash -d sync=~/Sync


# ------------------------------------------------------------------------------
# 14. PLUGINS, PROMPT & TOOLS (keep at the end, in this exact order)
# ------------------------------------------------------------------------------
#   1. autosuggestions   2. starship   3. zoxide   4. syntax highlighting (LAST)
# Each one only loads if it's installed, so a missing tool won't cause errors.

# AUTOSUGGESTIONS: grey ghost text from your history
#   PRESS: Right arrow or End   -> accept the whole suggestion
#   PRESS: Ctrl+Space           -> accept the whole suggestion
#   PRESS: Alt+F                -> accept just the next word
#   Just keep typing to ignore it.
if [[ -f $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#7a7a7a'          # lighten if hard to see
  source $ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^ ' autosuggest-accept
fi

# STARSHIP PROMPT: shows git branch, venv, timings, errors
#   Config file: ~/.config/starship.toml
#   TYPE: starship preset tokyo-night -o ~/.config/starship.toml   (change the look)
#   Icons need a Nerd Font set in your terminal's settings.
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

# ZOXIDE: smart cd
#   TYPE: cd projects     -> jumps to the best match from folders you've visited
#   TYPE: cd studio app   -> several words narrow it down
#   TYPE: cdi             -> interactive picker (needs fzf installed)
#   TYPE: cd -            -> back to the previous folder
if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# SYNTAX HIGHLIGHTING: green = valid command, red = not found
#   Nothing to press, works as you type.
#   MUST STAY THE LAST THING IN THIS FILE. Add anything new ABOVE this block.
if [[ -f $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)    # brackets = colour matching ( ) [ ] { }
  source $ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
