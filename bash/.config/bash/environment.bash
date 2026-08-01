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
export LESS='-FRX --mouse'
export LESSHISTFILE='-'
export MANPAGER='less -R --use-color -Dd+r -Du+b'

if [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate bash)"
fi

if [[ -d "$HOME/.dotnet/tools" ]]; then
  export PATH="$HOME/.dotnet/tools:$PATH"
fi

if [[ -z "${SSH_AUTH_SOCK:-}" ]]; then
  agent_env="$HOME/.ssh/agent.env"

  if [[ -r "$agent_env" ]]; then
    # shellcheck disable=SC1090
    source "$agent_env" >/dev/null 2>&1 || true
  fi

  if [[ -z "${SSH_AGENT_PID:-}" ]] ||
     ! kill -0 "$SSH_AGENT_PID" 2>/dev/null ||
     [[ ! -S "${SSH_AUTH_SOCK:-}" ]]; then
    mkdir -p "$HOME/.ssh"
    umask 077

    ssh-agent -s > "$agent_env"
    # shellcheck disable=SC1090
    source "$agent_env" >/dev/null
  fi

  unset agent_env
fi

if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_OPTS='
    --height=60%
    --layout=reverse
    --border=rounded
    --info=inline
    --prompt=›\ 
    --pointer=›
    --marker=✓
    --bind=ctrl-j:down,ctrl-k:up
    --bind=ctrl-d:half-page-down,ctrl-u:half-page-up
    --bind=ctrl-space:toggle
    --color=bg+:#2a2a37,bg:#1f1f28,spinner:#ffa066,hl:#e6c384
    --color=fg:#dcd7ba,header:#7aa89f,info:#727169,pointer:#ffa066
    --color=marker:#98bb6c,fg+:#dcd7ba,prompt:#7e9cd8,hl+:#e6c384
    --color=border:#363646
  '
fi
