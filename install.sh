#!/bin/bash

set -e

echo "🚀 installing dependences and configs..."
# 1. pacman pkgs
OFFICIAL_PKGS=(
    waybar
    rofi-wayland
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
    git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
fi

# 3. aur pkgs
AUR_PKGS=(
    mangowm
    swaylock-effects-git
)


echo "📦 installing packages from official repos..."
sudo pacman -S --needed --noconfirm "${OFFICIAL_PKGS[@]}"

echo "📦 installing packages from aur..."
yay -S --needed --noconfirm "${AUR_PKGS[@]}"



# 4. copying configs
echo "📑 copying configs..."
rm -rf ~/.config/waybar
rm -rf ~/.config/rofi
rm -rf ~/.config/kitty
rm -rf ~/.config/fastfetch
rm -rf ~/.config/mangowm
rm -rf ~/.config/swaylock

mkdir -p ~/.config
cp -rf config/* ~/.config/

echo "✅ installation finished!."
