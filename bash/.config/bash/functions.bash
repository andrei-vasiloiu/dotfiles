mkcd() {
  [[ $# -eq 1 ]] || {
    printf 'usage: mkcd DIRECTORY\n' >&2
    return 2
  }

  mkdir -p -- "$1" || return
  cd -- "$1" || return
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
    # shellcheck disable=SC2016
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
      fzf --prompt='directory › '
  )" || return

  if [[ -n "$directory" ]]; then
    cd -- "$directory" || return
  fi
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
      fzf --prompt='history › '
  )" || return

  [[ -n "$command" ]] || return

  READLINE_LINE="$command"
  READLINE_POINT=${#READLINE_LINE}
}

gco() {
  local branch

  git rev-parse --git-dir >/dev/null 2>&1 || {
    printf 'Not inside a Git repository\n' >&2
    return 1
  }

  branch="$(
    git for-each-ref \
      --sort=-committerdate \
      --format='%(refname:short)' \
      refs/heads |
      fzf --prompt='branch › '
  )" || return

  [[ -n "$branch" ]] && git switch -- "$branch"
}

glog() {
  local commit

  git rev-parse --git-dir >/dev/null 2>&1 || {
    printf 'Not inside a Git repository\n' >&2
    return 1
  }

  commit="$(
    git log \
      --color=always \
      --format='%C(yellow)%h%Creset %C(cyan)%ad%Creset %C(auto)%d%Creset %s %C(dim white)— %an%Creset' \
      --date=short |
      fzf \
        --ansi \
        --no-sort \
        --prompt='commit › ' \
        --preview="
          commit=\$(printf \"%s\" {} | sed -E \"s/^[^[:alnum:]]*([[:xdigit:]]+).*/\1/\")
          git show --color=always --stat --patch \"\$commit\"
        " \
        --preview-window='right,65%,wrap' |
      sed -E 's/^[^[:alnum:]]*([[:xdigit:]]+).*/\1/'
  )" || return

  [[ -n "$commit" ]] && git show --color=always "$commit" | less -R
}

bash-profile() {
  local profile

  profile="$(mktemp)"

  PS4='+ ${BASH_SOURCE}:${LINENO}: ' \
    BASH_XTRACEFD=3 \
    bash -xlic exit 3>"$profile" >/dev/null 2>&1

  if command -v batcat >/dev/null 2>&1; then
    batcat --language=bash --paging=always "$profile"
  elif command -v bat >/dev/null 2>&1; then
    bat --language=bash --paging=always "$profile"
  else
    less "$profile"
  fi

  rm -f "$profile"
}
