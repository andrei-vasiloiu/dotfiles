if ! declare -p BASH_COMPLETION_VERSINFO >/dev/null 2>&1; then
  if [[ -r /usr/share/bash-completion/bash_completion ]]; then
    # shellcheck disable=SC1091
    source /usr/share/bash-completion/bash_completion
  elif [[ -r /etc/bash_completion ]]; then
    # shellcheck disable=SC1091
    source /etc/bash_completion
  fi
fi

completion_dir="$HOME/.local/share/bash-completion/completions"

for command in gh uv uvx podman pnpm; do
  if [[ -r "$completion_dir/$command" ]]; then
    # shellcheck disable=SC1090
    source "$completion_dir/$command"
  fi
done

unset command completion_dir

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# Completion behavior
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'

# Complete aliases as their underlying commands
if command -v _complete_alias >/dev/null 2>&1; then
  complete -F _complete_alias \
    ll \
    la \
    lt
fi

# Debian package suggestions for unknown commands
if ! declare -F command_not_found_handle >/dev/null 2>&1; then
  if [[ -x /usr/lib/command-not-found ]]; then
    command_not_found_handle() {
      /usr/lib/command-not-found -- "$1"
      return $?
    }
  elif [[ -x /usr/share/command-not-found/command-not-found ]]; then
    command_not_found_handle() {
      /usr/share/command-not-found/command-not-found -- "$1"
      return $?
    }
  fi
fi
