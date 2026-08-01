#!/usr/bin/env bash

require_x86_64() {
  local architecture

  architecture="$(uname -m)"

  if [[ "$architecture" != "x86_64" ]]; then
    printf 'ERROR: x86_64 is required; detected %s.\n' "$architecture" >&2
    exit 1
  fi
}

is_wsl() {
  [[ -r /proc/sys/kernel/osrelease ]] &&
    grep -qi microsoft /proc/sys/kernel/osrelease
}

is_debian() {
  [[ -r /etc/debian_version ]]
}

require_debian() {
  if ! is_debian; then
    printf 'ERROR: Debian is required.\n' >&2
    exit 1
  fi
}

require_wsl() {
  if ! is_wsl; then
    printf 'ERROR: WSL is required.\n' >&2
    exit 1
  fi
}
