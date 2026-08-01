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
  local elapsed=$SECONDS
  local status=""
  local duration=""

  SECONDS=0

  if (( exit_code != 0 )); then
    status="  \[\e[38;5;203m\]exit:${exit_code}\[\e[0m\]"
  fi

  if (( elapsed >= 2 )); then
    duration="  \[\e[38;5;179m\]${elapsed}s\[\e[0m\]"
  fi

  PS1="\[\e[38;5;75m\]\w\[\e[0m\]$(__prompt_git)${status}${duration}"
  PS1+="\n\[\e[38;5;114m\]❯\[\e[0m\] "
}

__prompt_history_sync() {
  history -a
  history -n
}

if ! declare -p PROMPT_COMMAND 2>/dev/null | grep -q 'declare \-a'; then
  existing_prompt_command="${PROMPT_COMMAND:-}"
  unset PROMPT_COMMAND
  declare -a PROMPT_COMMAND=()

  if [[ -n "$existing_prompt_command" ]]; then
    PROMPT_COMMAND+=("$existing_prompt_command")
  fi

  unset existing_prompt_command
fi

SECONDS=0

PROMPT_COMMAND+=(
  __prompt_history_sync
  __prompt_command
)
