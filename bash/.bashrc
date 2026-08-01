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
. "$HOME/.local/bin/env"

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
