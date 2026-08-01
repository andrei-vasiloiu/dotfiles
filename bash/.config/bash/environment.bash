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

if [[ -d "$HOME/.cargo/bin" ]]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

if [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate bash)"
fi

if [[ -d "$HOME/.dotnet/tools" ]]; then
  export PATH="$HOME/.dotnet/tools:$PATH"
fi
