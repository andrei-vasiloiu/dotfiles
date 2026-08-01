#!/usr/bin/env bash

log_step() {
  printf '\n==> %s\n' "$1"
}

log_info() {
  printf '    %s\n' "$1"
}

log_warn() {
  printf 'WARN: %s\n' "$1" >&2
}

log_error() {
  printf 'ERROR: %s\n' "$1" >&2
}
