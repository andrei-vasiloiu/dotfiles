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

cdf() {
  local directory

  directory="$(
    fd \
      --type directory \
      --hidden \
      --exclude .git \
      . "${1:-.}" |
      fzf --prompt='directory › ' --height=40% --reverse
  )" || return

  [[ -n "$directory" ]] && cd -- "$directory"
}

vf() {
  local file

  file="$(
    fd \
      --type file \
      --hidden \
      --exclude .git |
      fzf \
        --prompt='file › ' \
        --height=60% \
        --reverse \
        --preview 'batcat --color=always --style=numbers --line-range=:300 {} 2>/dev/null || sed -n "1,300p" {}'
  )" || return

  [[ -n "$file" ]] && "${EDITOR:-nvim}" -- "$file"
}

fh() {
  local command

  command="$(
    history |
      sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//' |
      awk '!seen[$0]++' |
      fzf --prompt='history › ' --height=60% --reverse
  )" || return

  [[ -n "$command" ]] || return

  READLINE_LINE="$command"
  READLINE_POINT=${#READLINE_LINE}
}
