alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'
alias h='history'
alias j='jobs -l'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

alias ls='eza --group-directories-first'
alias ll='eza --long --group --git --group-directories-first'
alias la='eza --long --all --group --git --group-directories-first'
alias lt='eza --tree --level=2 --group-directories-first'

alias cat='batcat --paging=never'
alias fd='fdfind'
alias rg='rg --smart-case'

alias gs='git status --short --branch'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph'
