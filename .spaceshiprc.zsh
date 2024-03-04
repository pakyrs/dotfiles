SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (if you are in a git repository)
  hg            # Mercurial section (if you are in a Mercurial repository)
  exec_time     # Execution time of the last command
  line_sep      # Line break
 # vi_mode       # Vi-mode indicator (if you have vi-mode enabled in your Zsh)
  jobs          # Background jobs indicator
  exit_code     # Exit code of the last command
  char          # Prompt character
)

SPACESHIP_USER_SHOW=always
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CHAR_SYMBOL_SUCCESS='❯'
SPACESHIP_CHAR_SYMBOL_FAILURE='❯'

# Dracula color scheme
SPACESHIP_PROMPT_COLOR_SUCCESS=green
SPACESHIP_PROMPT_COLOR_ERROR=red
SPACESHIP_PROMPT_COLOR_DIR_DEFAULT=blue
SPACESHIP_PROMPT_COLOR_DIR_ROOT=red
SPACESHIP_PROMPT_COLOR_USER='240'
SPACESHIP_PROMPT_COLOR_HOST='240'
SPACESHIP_PROMPT_COLOR_EXEC_TIME='240'
SPACESHIP_PROMPT_COLOR_JOBS='240'
SPACESHIP_PROMPT_COLOR_VI_MODE_INSERT='240'
SPACESHIP_PROMPT_COLOR_VI_MODE_NORMAL='240'
SPACESHIP_PROMPT_COLOR_VI_MODE_CURSOR='240'

# Customize git icons
SPACESHIP_GIT_BRANCH_PREFIX=' on '
SPACESHIP_GIT_BRANCH_SUFFIX=''
SPACESHIP_GIT_SYMBOL_UNTRACKED='✭'
SPACESHIP_GIT_SYMBOL_ADDED='✚'
SPACESHIP_GIT_SYMBOL_MODIFIED='✹'
SPACESHIP_GIT_SYMBOL_DELETED='✖'
SPACESHIP_GIT_SYMBOL_RENAMED='➜'
SPACESHIP_GIT_SYMBOL_UNMERGED='═'
SPACESHIP_GIT_SYMBOL_AHEAD='⇡'
SPACESHIP_GIT_SYMBOL_BEHIND='⇣'
SPACESHIP_GIT_STATUS_FORMAT="%s%s%s %s%s"

# Enable additional modules if needed
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_USER_SHOW=always
SPACESHIP_EXEC_TIME_SHOW=true

