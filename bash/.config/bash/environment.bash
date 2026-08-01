HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=100000
HISTTIMEFORMAT='%F %T  '

shopt -s histappend
shopt -s cmdhist
shopt -s lithist

export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-R'
