#!/bin/sh
while IFS= read -r line
do
  lineEscaped="$(printf "%s" "$line" | sed -e 's/_/__/g; s/`/_BACK_TICK_/g; s/(/_OPEN_P_/g; s/\[/_OPEN_SB_/g; s/\"/\\\"/g')"
  eval "printf '%s\n' \"$lineEscaped\"" | sed 's/_BACK_TICK_/`/g; s/_OPEN_P_/(/g; s/_OPEN_SB_/\[/g; s/__/_/g'
done < $1
