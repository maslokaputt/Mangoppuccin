#!/bin/bash

set -euo pipefail

# Always run from the repo directory, so relative paths (config/) work
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "🚀 installing dependencies and configs..."

# 0. sanity checks
if ! command -v pacman &> /dev/null; then
    echo "❌ pacman not found. This script needs an Arch-based distro."
    exit 1
fi

if [ "$EUID" -eq 0 ]; then
    echo "❌ do not run as root (makepkg/yay refuse it)."
    exit 1
fi

if [ ! -d "config" ]; then
    echo "❌ config/ folder not found next to install.sh."
    exit 1
fi

# 1. pacman pkgs
# rofi-wayland was merged into rofi in newer repos; use whichever exists
if pacman -Si rofi-wayland &> /dev/null; then
    ROFI_PKG="rofi-wayland"
else
    ROFI_PKG="rofi"
fi

OFFICIAL_PKGS=(
    waybar
    "$ROFI_PKG"
    swaybg
    swayidle
    kitty
    fastfetch
    ttf-jetbrains-mono-nerd
    papirus-icon-theme
    fish
    starship
)

# 2. yay (if not installed)
if ! command -v yay &> /dev/null; then
    echo "📦 installing yay..."
    sudo pacman -S --needed base-devel git
    YAY_TMP="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$YAY_TMP/yay"
    (cd "$YAY_TMP/yay" && makepkg -si)
    rm -rf "$YAY_TMP"
fi

# 3. aur pkgs
AUR_PKGS=(
    mangowm
    swaylock-effects-git
)

echo "📦 installing packages from official repos..."
sudo pacman -S --needed --noconfirm "${OFFICIAL_PKGS[@]}"

# no --noconfirm here: lets you review AUR PKGBUILDs before building
echo "📦 installing packages from aur..."
yay -S --needed "${AUR_PKGS[@]}"

# 4. copying configs (existing ones are backed up, not deleted)
echo "📑 copying configs..."

CONFIG_DIRS=(waybar rofi kitty fastfetch mangowm swaylock)
BACKUP_DIR="$HOME/.config-backup/mangoppuccin-$(date +%Y%m%d-%H%M%S)"

mkdir -p "$HOME/.config"

for dir in "${CONFIG_DIRS[@]}"; do
    if [ -e "$HOME/.config/$dir" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$HOME/.config/$dir" "$BACKUP_DIR/"
        echo "   backed up: ~/.config/$dir"
    fi
done

cp -rf config/. "$HOME/.config/"

echo "✅ installation finished!"
if [ -d "$BACKUP_DIR" ]; then
    echo "   old configs saved in: $BACKUP_DIR"
fi
