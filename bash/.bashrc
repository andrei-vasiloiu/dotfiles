# shellcheck shell=bash
case $- in
  *i*) ;;
    *) return ;;
esac

BASH_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}/bash"

for file in \
  environment.bash \
  completion.bash \
  aliases.bash \
  functions.bash \
  prompt.bash
do
  # shellcheck disable=SC1090
  [[ -r "$BASH_CONFIG_HOME/$file" ]] && source "$BASH_CONFIG_HOME/$file"
done

unset file

# shellcheck disable=SC1091
if [[ -r "$HOME/.local/bin/env" ]]; then
  source "$HOME/.local/bin/env"
fi

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac

# neovim
export NVIM_HOME="/opt/nvim-linux-x86_64"
case ":$PATH:" in
  *":$NVIM_HOME/bin:"*) ;;
  *) export PATH="$NVIM_HOME/bin:$PATH" ;;
esac

if declare -F vf >/dev/null 2>&1; then
  bind -x '"\C-f": vf'
fi
