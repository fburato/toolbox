#!/bin/sh
# Uses the first argument provided as file template and applies all standard
# variable substitutions available with environment variables defined.
# Works with bash, sh, zsh. Tested with /bin/sh in base docker alpine dist.
while IFS= read -r line
do
  # remove all `,( and [ to avoid unsafe execution of eval
  # escape " to allow correct substitution
  lineEscaped="$(printf "%s" "$line" | sed 's/_/__/g; s/`/_BACK_TICK_/g; s/(/_OPEN_P_/g; s/\[/_OPEN_SB_/g; s/\"/\\\"/g')"
  # execute variable substitution and restore `,( and [
  eval "printf '%s\n' \"$lineEscaped\"" | sed 's/_BACK_TICK_/`/g; s/_OPEN_P_/(/g; s/_OPEN_SB_/\[/g; s/__/_/g'
done < $1
