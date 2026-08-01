mkcd() {
  [[ $# -eq 1 ]] || {
    printf 'usage: mkcd DIRECTORY\n' >&2
    return 2
  }

  mkdir -p -- "$1" && cd -- "$1"
}

tm() {
  tmux new-session -A -s "${1:-main}"
}

copy() {
  local clip="/mnt/c/Windows/System32/clip.exe"

  if [[ -x "$clip" ]]; then
    "$clip"
  elif command -v wl-copy >/dev/null 2>&1; then
    wl-copy
  else
    printf 'No clipboard command available\n' >&2
    return 1
  fi
}

paste() {
  local powershell="/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe"

  if [[ -x "$powershell" ]]; then
    "$powershell" \
      -NoLogo \
      -NoProfile \
      -Command \
      '[Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))'
  elif command -v wl-paste >/dev/null 2>&1; then
    wl-paste
  else
    printf 'No clipboard command available\n' >&2
    return 1
  fi
}
