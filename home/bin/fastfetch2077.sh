#!/usr/bin/env bash

# Deine fastfetch config
CONFIG="$HOME/.config/fastfetch/config.jsonc"
# Dein Quote-File
QUOTES="$HOME/.config/fastfetch/quotes.txt"

# Fastfetch Output in Variable speichern
FFOUT="$(fastfetch --load-config "$CONFIG")"

# Zufälligen Quote auswählen
if [ -f "$QUOTES" ]; then
  QUOTE=$(shuf -n 1 "$QUOTES")
else
  QUOTE="„No quote found. Add more style to ~/.config/fastfetch/quotes.txt!“"
fi

# ASCII-Separator in Glow
SEP="\033[38;5;201m═══════════════════════════════════\033[0m"

# Spaß-Modul aktivieren – für Collector’s Arcade Mode!
source "$HOME/.config/fastfetch/fastfetch2077_fun.sh"

# Ausgabe mit Glow (lolcat)
{
  echo "$FFOUT"
  echo -e "$SEP"
  echo -e "\033[3;38;5;208m$QUOTE\033[0m"
  echo -e "$SEP"
} | lolcat
