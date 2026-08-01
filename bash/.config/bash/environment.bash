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

if [[ -x "$HOME/.local/bin/mise" ]]; then
  eval "$("$HOME/.local/bin/mise" activate bash)"
fi

if [[ -d "$HOME/.dotnet/tools" ]]; then
  export PATH="$HOME/.dotnet/tools:$PATH"
fi

if [[ -z "${SSH_AUTH_SOCK:-}" ]]; then
  agent_env="$HOME/.ssh/agent.env"

  if [[ -r "$agent_env" ]]; then
    source "$agent_env" >/dev/null 2>&1 || true
  fi

  if [[ -z "${SSH_AGENT_PID:-}" ]] ||
     ! kill -0 "$SSH_AGENT_PID" 2>/dev/null ||
     [[ ! -S "${SSH_AUTH_SOCK:-}" ]]; then
    mkdir -p "$HOME/.ssh"
    umask 077

    ssh-agent -s > "$agent_env"
    source "$agent_env" >/dev/null
  fi

  unset agent_env
fi
