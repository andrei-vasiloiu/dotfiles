alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'
alias h='history'
alias j='jobs -l'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza --long --group --git --group-directories-first'
  alias la='eza --long --all --group --git --group-directories-first'
  alias lt='eza --tree --level=2 --group-directories-first'
else
  alias ll='ls -lah'
  alias la='ls -la'
fi

if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
elif command -v batcat >/dev/null 2>&1; then
  alias cat='batcat --paging=never'
fi

if command -v fd >/dev/null 2>&1; then
  alias fd='fd'
elif command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi

alias rg='rg --smart-case'

alias gs='git status --short --branch'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph'

alias v='nvim'
