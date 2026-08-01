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
    source "$agent_env" >/dev/null
  fi

  if ! ssh-add -l >/dev/null 2>&1; then
    mkdir -p "$HOME/.ssh"
    umask 077
    ssh-agent -s > "$agent_env"
    source "$agent_env" >/dev/null
  fi
fi
