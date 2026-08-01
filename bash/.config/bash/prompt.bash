__prompt_git() {
  local branch

  branch="$(git symbolic-ref --quiet --short HEAD 2>/dev/null)" ||
    branch="$(git rev-parse --short HEAD 2>/dev/null)" ||
    return

  if ! git diff --quiet --ignore-submodules -- 2>/dev/null ||
     ! git diff --cached --quiet --ignore-submodules -- 2>/dev/null; then
    branch+="*"
  fi

  printf '  \[\e[38;5;110m\]%s\[\e[0m\]' "$branch"
}

__prompt_command() {
  local exit_code=$?
  local status=""

  if (( exit_code != 0 )); then
    status="  \[\e[38;5;203m\]exit:${exit_code}\[\e[0m\]"
  fi

  PS1="\[\e[38;5;75m\]\w\[\e[0m\]$(__prompt_git)${status}"
  PS1+="\n\[\e[38;5;114m\]❯\[\e[0m\] "
}

PROMPT_COMMAND="history -a; history -n; __prompt_command"
