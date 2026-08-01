#!/usr/bin/env bash

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
