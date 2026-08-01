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

log_failure() {
  local exit_code="$1"
  local line_number="$2"
  local command="$3"

  log_error "Command failed with exit code ${exit_code}"
  log_error "Line ${line_number}: ${command}"
}

enable_error_trap() {
  trap 'log_failure "$?" "$LINENO" "$BASH_COMMAND"' ERR
}
