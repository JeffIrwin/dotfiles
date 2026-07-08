
#===========================================================

export TIMEFMT=$'real\t%E\nuser\t%U\nsys\t%S'

#****************

PATH="$HOME/Library/Python/3.9/bin:$PATH"
PATH=~/.local/bin/:$PATH
export PATH

#===========================================================

# Ctrl+u delete's the whole line on mac by default. Make it only delete from
# start to cursor like sane operating systems
bindkey ^U backward-kill-line

#===========================================================
#
# Prompt colors for user, host, and pwd
PROMPT='%F{green}%n@%m%f %F{blue}%1~%f %# '
autoload -U colors && colors

# Enable colors for ls on macOS
export CLICOLOR=1

#===========================================================

## No alias needed since isocline in syntran 1.4.0
#alias syntran="rlwrap syntran"

alias sy="rlwrap syntran"

alias vim=nvim
alias vi=nvim

#===========================================================

source ~/.zsh_secrets

alias jeff-galatnix="ssh -t jeff@192.168.0.109"
