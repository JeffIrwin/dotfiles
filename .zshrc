
PATH="$HOME/Library/Python/3.9/bin:$PATH"
PATH=~/.local/bin/:$PATH
export PATH

#===========================================================

# Show "time" shell command output on newlines rather than user/sys/etc crammed
# into a single line
export TIMEFMT=$'real\t%E\nuser\t%U\nsys\t%S'

#****************

# Ctrl+u delete's the whole line on mac by default. Make it only delete from
# start to cursor like sane operating systems
bindkey ^U backward-kill-line

# Initialize completions
autoload -Uz compinit
compinit

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# TAB cycles through matches instead of listing them
bindkey '^I' menu-complete

# Ctrl+Arrow to move left/right by word
#
# This also requires fucking with some bullshit in mac settings:
#
#     Disable macOS Mission Control Shortcuts
#
#     macOS uses these exact shortcuts globally. You must turn them off so the
#     terminal can receive the keypresses:
#     - Open System Settings (or System Preferences).
#     - Navigate to Keyboard > Keyboard Shortcuts....
#     - Click on Mission Control in the left sidebar.
#     - Expand the Mission Control drop-down menu in the main pane.
#     - Uncheck Move left a space (^←) and Move right a space (^→).
#
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

#===========================================================

# Prompt colors for user, host, and pwd
PROMPT='%F{green}%n@%m%f %F{blue}%1~%f %# '
autoload -U colors && colors

# Enable colors for ls on macOS
export CLICOLOR=1

#===========================================================

## No alias needed since isocline in syntran 1.4.0
#alias syntran="rlwrap syntran"

alias sy="syntran"

alias vim=nvim
alias vi=nvim

alias o=open

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

#===========================================================

source ~/.zsh_secrets

alias jeff-galatnix="ssh -t jeff@192.168.0.109"
