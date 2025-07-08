# ~/.config/fastfetch/clippy.sh

CLIPPY_ON=1   # auf 0 setzen, um Clippy zu deaktivieren

# --- Quotes-Array: Für jeden Tag ein Spruch (füge weitere hinzu, so viele du willst) ---
clippy_quotes=(
  "Clippy sagt: rm -rf kann dein bester Freund oder dein schlimmster Feind sein."
  "Clippy Tipp: Wer grep nicht kennt, sucht noch per Hand."
  "Clippy sagt: Kaffee ist kein optionales Paket."
  "Clippy: Schon mal an ein Backup gedacht? Nein? Du wirst es bereuen."
  "Clippy meint: Wenn alles funktioniert, hast du bestimmt was übersehen."
  "Clippy: Erst testen, dann produktiv schalten. Hoffentlich."
  "Clippy sagt: Ein Admin ohne Fehler ist wie ein Server ohne Logs – gibt’s nicht."
  "Clippy Tipp: Wer viel fragt, kriegt viele Antworten. Manchmal auch dumme."
  "Clippy: Uptime beeindruckt nur solange, bis das nächste Kernel-Update kommt."
  "Clippy meint: Wenn’s brennt, ist immer Freitag 16:59 Uhr."
  "Clippy sagt: sudo macht aus jedem Skript eine Zeitbombe."
  "Clippy: Du bist heute schon ganz schön lange im Terminal!"
  "Clippy meint: Die Cloud ist nur der Rechner von jemand anderem."
  "Clippy Tipp: Wer YAML sagt, muss auch Fluchen können."
  "Clippy sagt: Nichts motiviert mehr als ein Server-Ausfall."
  "Clippy: Montags deployen – nur für Mutige."
  "Clippy meint: Logs lesen ist wie Kaffeesatzlesen – nur bitterer."
  "Clippy Tipp: Wer crontab vergisst, steht sonntags auf der Arbeit."
  "Clippy sagt: SSH – Der geheime Tunnel für digitale Ninjas."
  "Clippy: Script nicht getestet, aber wird schon laufen."
  "Clippy meint: Hinter jedem rm -rf steckt ein Abenteuer."
  "Clippy Tipp: Wer push ohne Pull macht, lebt gefährlich."
  "Clippy sagt: Git ist wie Magie – aber manchmal verschwindet alles."
  "Clippy: curl und wget – die wahren Tools des Internetzeitalters."
  "Clippy meint: Ein gutes Passwort ist wie ein guter Kaffee – stark und unverwechselbar."
  "Clippy Tipp: Wer viel loggt, findet auch viele Fehler."
  "Clippy sagt: Wer seinen Bash-History kennt, fürchtet keine Kommandozeile."
  "Clippy: Regex ist ein Rätsel, das niemand lösen soll."
  "Clippy meint: Wer bis hierher liest, hat schon gewonnen."
  "Clippy Tipp: Feierabend ist der beste Admin-Workaround."
  "Clippy sagt: Das war’s für heute – vielleicht."
)

Write-Clippy() {
  local day_index=$(( $(date +%-d) - 1 ))
  local MSG="${clippy_quotes[ day_index % ${#clippy_quotes[@]} ]}"
#  local clippy='
#   _  _
#  ( `   )_
# (    )    `)
#(____(__.___ )'
  if [[ "$CLIPPY_ON" == "1" ]]; then
    echo -e "\033[1;36m$clippy\n\033[1;35m👾 $MSG\033[0m" | lolcat
  fi
}
