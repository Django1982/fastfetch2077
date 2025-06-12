#!/usr/bin/env bash
# Fastfetch 2077 Fun-Modul – Gameification, Achievements, Tagesmodi

# --- Tageszeit-Modus ---
HOUR=$(date +%-H)
MODE="classic"
if (( HOUR >= 6 && HOUR < 12 )); then
  MODE="morning"
elif (( HOUR >= 12 && HOUR < 18 )); then
  MODE="afternoon"
elif (( HOUR >= 18 && HOUR < 22 )); then
  MODE="evening"
else
  MODE="night"
fi

case "$MODE" in
  morning)
    BANNER="☀️  Rise and shine, Hacker!"
    ;;
  afternoon)
    BANNER="🚀 Keep it rollin’, Cyber-Boss!"
    ;;
  evening)
    BANNER="🌆 Neon Mode: Ready for Night Shift!"
    ;;
  night)
    BANNER="🌙 Midnight Shell – Stay stealthy!"
    ;;
  *)
    BANNER="🦾 Fastfetch 2077: Danny Edition"
    ;;
esac

echo "$BANNER" | lolcat

# --- Wochentag-Specials ---
DAY=$(date +%-u)  # 1 = Montag, 7 = Sonntag
SPECIAL=""
case "$DAY" in
  1) SPECIAL="Montagsmodus: Kaffee intravenös empfohlen." ;;
  5) SPECIAL="Freitag: Der Bash ist mit dir, Feierabend winkt!" ;;
  6|7) SPECIAL="Wochenende detected: Hacker chillen auch mal." ;;
esac

if [[ -n "$SPECIAL" ]]; then
  echo "$SPECIAL" | lolcat
fi

# --- Collector’s Highscore ---
COUNTER_FILE="$HOME/.fastfetch2077_counter"
if [ ! -f "$COUNTER_FILE" ]; then
  echo 1 > "$COUNTER_FILE"
else
  CNT=$(cat "$COUNTER_FILE")
  CNT=$((CNT+1))
  echo "$CNT" > "$COUNTER_FILE"
fi

CNT=$(cat "$COUNTER_FILE")
echo -e "\033[38;5;208m🟢 Collector's Score: $CNT Fastfetch-Sessions!\033[0m" | lolcat

# --- Achievement-System ---
ACH_FILE="$HOME/.fastfetch2077_achievements"
[ ! -f "$ACH_FILE" ] && touch "$ACH_FILE"

add_achievement() {
  ACH="$1"
  if ! grep -Fxq "$ACH" "$ACH_FILE"; then
    echo "$ACH" >> "$ACH_FILE"
    echo -e "\033[38;5;45m🏆 Achievement unlocked: $ACH\033[0m" | lolcat
  fi
}

# Beispiel-Achievements
if (( CNT >= 10 )); then
  add_achievement "10x Collector – Du hast Fastfetch 10x benutzt!"
fi
if (( CNT >= 100 )); then
  add_achievement "💯 Terminal-Legende – 100 Logins!"
fi
if [[ "$DAY" -eq 1 ]]; then
  add_achievement "Montagsheld – Schon montags gehackt!"
fi
if (( HOUR == 4 && $(date +%-M) == 20 )); then
  add_achievement "420 Mode – Du bist viel zu spät/nachts dran!"
fi

echo -e "\033[38;5;198mAchievements bisher:\033[0m"
cat "$ACH_FILE" | lolcat
