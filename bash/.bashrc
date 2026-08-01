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
  [[ -r "$BASH_CONFIG_HOME/$file" ]] && source "$BASH_CONFIG_HOME/$file"
done

unset file
