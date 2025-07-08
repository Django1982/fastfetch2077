#!/usr/bin/env bash
set -e

REPO_BASE="https://raw.githubusercontent.com/Django1982/fastfetch2077/main"
BIN_DIR="$HOME/bin"
CONFIG_DIR="$HOME/.config/fastfetch"

# --- 1. Verzeichnisse vorab anlegen! ---
mkdir -p "$BIN_DIR" "$CONFIG_DIR"

# --- 2. Architektur/OS-Erkennung ---
ARCH=$(uname -m)
OS=$(grep -E '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')

case "$ARCH" in
    x86_64)   ARCH_DEB="amd64" ;;
    aarch64)  ARCH_DEB="aarch64" ;;
    armv7l)   ARCH_DEB="armhf" ;;
    *)        echo "Unbekannte Architektur: $ARCH – manuell nachinstallieren!"; exit 1 ;;
esac

FF_INSTALLED=0
if ! command -v fastfetch >/dev/null 2>&1; then
  case "$OS" in
    debian|ubuntu|raspbian)
      echo "Fastfetch wird installiert (Debian/Ubuntu/Derivat)..."
      FF_URL=$(curl -s https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest \
              | grep "browser_download_url" \
              | grep "fastfetch-linux-$ARCH_DEB.deb" \
              | cut -d '"' -f 4)
      if [ -z "$FF_URL" ]; then
          echo "Konnte keine passende Fastfetch-Version finden!"; exit 2
      fi
      TMP_DEB="/tmp/fastfetch2077.deb"
      wget -O "$TMP_DEB" "$FF_URL"
      sudo dpkg -i "$TMP_DEB" || sudo apt-get install -f -y
      rm "$TMP_DEB"
      FF_INSTALLED=1
      ;;
    arch)
      echo "Bitte installiere fastfetch manuell:"
      echo "    sudo pacman -S fastfetch"
      ;;
    alpine)
      echo "Bitte installiere fastfetch manuell:"
      echo "    sudo apk add fastfetch"
      ;;
    fedora)
      echo "Bitte installiere fastfetch manuell:"
      echo "    sudo dnf install fastfetch"
      ;;
    *)
      echo "Dein OS wird aktuell nicht automatisch unterstützt."
      echo "Installiere fastfetch bitte selbst und starte das Script dann erneut."
      ;;
  esac
else
  FF_INSTALLED=1
fi

if ! command -v lolcat >/dev/null 2>&1; then
  case "$OS" in
    debian|ubuntu|raspbian)
      echo "lolcat wird installiert..."
      sudo apt-get update && sudo apt-get install -y lolcat
      ;;
    arch)
      echo "Bitte installiere lolcat manuell:"
      echo "    sudo pacman -S lolcat"
      ;;
    alpine)
      echo "Bitte installiere lolcat manuell:"
      echo "    sudo apk add lolcat"
      ;;
    fedora)
      echo "Bitte installiere lolcat manuell:"
      echo "    sudo dnf install ruby-lolcat"
      ;;
    *)
      echo "Installiere lolcat bitte selbst!"
      ;;
  esac
fi

# --- 3. Repo-Files holen (jetzt können die Verzeichnisse garantiert befüllt werden) ---
curl -sL "$REPO_BASE/home/bin/fastfetch2077.sh" -o "$BIN_DIR/fastfetch2077.sh"
chmod +x "$BIN_DIR/fastfetch2077.sh"

curl -sL "$REPO_BASE/home/bin/fastfetch2077_fun.sh" -o "$BIN_DIR/fastfetch2077_fun.sh"
chmod +x "$BIN_DIR/fastfetch2077_fun.sh"

curl -sL "$REPO_BASE/home/bin/clippy.sh" -o "$BIN_DIR/clippy.sh"
chmod +x "$BIN_DIR/clippy.sh"

curl -sL "$REPO_BASE/home/config/fastfetch/config.jsonc" -o "$CONFIG_DIR/config.jsonc"
curl -sL "$REPO_BASE/home/config/fastfetch/quotes.txt" -o "$CONFIG_DIR/quotes.txt"

# --- 4. MOTD-Skript (optional) ---
if [ "${NO_MOTD:-0}" = 0 ]; then
  sudo mkdir -p /etc/profile.d
  sudo curl -sL "$REPO_BASE/etc/profile.d/fastfetch2077.sh" -o "/etc/profile.d/fastfetch2077.sh"
  sudo chmod +x /etc/profile.d/fastfetch2077.sh
fi

echo -e "\033[1;38;5;207mFastfetch 2077: Danny Edition installiert! Starte \033[38;5;51mfastfetch2077.sh\033[38;5;207m oder logge dich neu ein für Cyberpunk-Glow.\033[0m"
