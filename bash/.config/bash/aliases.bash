alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias c='clear'
alias h='history'
alias j='jobs -l'

alias grep='grep --color=auto'
alias diff='diff --color=auto'

if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza --long --header --group --git --icons=auto --group-directories-first'
  alias la='eza --long --header --all --group --git --icons=auto --group-directories-first'
  alias lt='eza --tree --level=2 --icons=auto --group-directories-first --ignore-glob=".git|node_modules|.venv|dist|build|bin|obj"'
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
  :
elif command -v fdfind >/dev/null 2>&1; then
  alias fd='fdfind'
fi


alias gs='git status --short --branch'
alias gd='git diff'
alias gl='git log --oneline --decorate --graph'

alias v='nvim'

alias sqlite3='sqlite3 -init "${XDG_CONFIG_HOME:-$HOME/.config}/sqlite3/sqliterc"'

alias ff='fd --type file --hidden \
  --exclude .git \
  --exclude node_modules \
  --exclude dist \
  --exclude build \
  --exclude coverage \
  --exclude target \
  --exclude .venv \
  --exclude bin \
  --exclude obj'
alias fdall='fd --hidden --no-ignore'

# Safer interactive file operations
alias cp='cp --interactive'
alias mv='mv --interactive'
alias rm='rm --interactive=once'
alias mkdir='mkdir --parents'
