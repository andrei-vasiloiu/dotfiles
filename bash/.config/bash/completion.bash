if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  # shellcheck disable=SC1091
  source /usr/share/bash-completion/bash_completion
elif [[ -r /etc/bash_completion ]]; then
  # shellcheck disable=SC1091
  source /etc/bash_completion
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

if command -v fzf >/dev/null 2>&1; then
  if fzf --bash >/dev/null 2>&1; then
    eval "$(fzf --bash)"
  elif [[ -r /usr/share/doc/fzf/examples/key-bindings.bash ]]; then
    # shellcheck disable=SC1091
    source /usr/share/doc/fzf/examples/key-bindings.bash
    # shellcheck disable=SC1091
    source /usr/share/doc/fzf/examples/completion.bash
  fi
fi

if command -v fzf >/dev/null 2>&1; then
  bind -x '"\C-f": vf'
  bind -x '"\C-gb": gco'
  bind -x '"\C-gl": glog'
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
