HISTCONTROL=ignoreboth:erasedups
HISTSIZE=50000
HISTFILESIZE=100000
HISTTIMEFORMAT='%F %T  '
export HISTIGNORE='&:ls:ll:la:lt:cd:cd ..:pwd:clear:history:exit'

shopt -s histappend
shopt -s histverify
shopt -s cmdhist
shopt -s lithist

export EDITOR=nvim
export VISUAL=nvim
export GIT_EDITOR=nvim
export GH_EDITOR=nvim
export SYSTEMD_EDITOR=nvim
export SUDO_EDITOR=nvim

export PAGER=less
export GH_PAGER=less
export SYSTEMD_PAGER=less
export LESS='-FRX --mouse'
export LESSHISTFILE='-'
export MANPAGER='less -R --use-color -Dd+r -Du+b'
export PROMPT_DIRTRIM=4

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

# Interactive shell ergonomics
shopt -s autocd
shopt -s cdspell
shopt -s checkwinsize
shopt -s direxpand
shopt -s globstar

export RIPGREP_CONFIG_PATH="${XDG_CONFIG_HOME:-$HOME/.config}/ripgrep/config"


if command -v dircolors >/dev/null 2>&1 &&
   [[ -r "$HOME/.dircolors" ]]; then
  eval "$(dircolors --sh "$HOME/.dircolors")"
fi

export EZA_TIME_STYLE=long-iso

# CLI color output
export CLICOLOR=1
export COLORTERM=truecolor

export GREP_COLORS='ms=01;38;5;179:mc=01;38;5;179:sl=:cx=:fn=38;5;110:ln=38;5;109:bn=38;5;109:se=38;5;167'

export GCC_COLORS='error=01;38;5;167:warning=01;38;5;179:note=01;38;5;110:caret=01;38;5;114:locus=38;5;109:quote=01;38;5;223'

export JQ_COLORS='0;38;5;223:0;38;5;223:0;38;5;179:0;38;5;179:0;38;5;114:0;38;5;110:0;38;5;141'

export JQ_COLORS='1;30:0;37:0;33:0;36:0;32:0;35'

export SQLITE_HISTORY="${XDG_STATE_HOME:-$HOME/.local/state}/sqlite3/history"
export SQLITE_TMPDIR="${TMPDIR:-/tmp}"

__dedupe_path() {
  local entry
  local -A seen=()
  local -a unique=()

  IFS=: read -r -a entries <<< "$PATH"

  for entry in "${entries[@]}"; do
    [[ -n "$entry" ]] || continue

    if [[ -z "${seen[$entry]:-}" ]]; then
      seen["$entry"]=1
      unique+=("$entry")
    fi
  done

  PATH="$(IFS=:; printf '%s' "${unique[*]}")"
  export PATH

  unset entries
}

__dedupe_path
unset -f __dedupe_path
