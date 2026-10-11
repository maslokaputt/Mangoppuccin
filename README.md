# 🥭 Mangoppuccin (Catppuccin mocha) dotfiles

A clean, modern, and aesthetic **mangoWM** (Wayland) environment styled with the **Catppuccin Mocha** color palette.

#⌨️ Keybindings

For a full list of custom keybindings and shortcuts, check keybinds.md.

---

## 🎨 Overview & Components

* **Window Manager:** `mangoWM`
* **Status Bar:** `Waybar` (Pill layout)
* **Application Launcher:** `Rofi` (Wayland)
* **Terminal:** `Kitty`
* **Lock Screen:** `Swaylock-effects`
* **System Fetch:** `Fastfetch`
* **Font:** `JetBrainsMono Nerd Font`
* **Icon Theme:** `Papirus`

---

## 🚀 Quick Start
## BEFORE INSTALLING DOWNLOAD GIT AND YAY
## ⚠️ Notice: The script will remove existing configuration folders for waybar, rofi, kitty, fastfetch, mangowm, and swaylock before copying the new ones.
```
# 1. Clone the repository
git clone https://github.com/maslokaputt/Mangoppuccin.git
cd Mangoppuccin

# 2. Make the script executable and run it
chmod +x install.sh
./install.sh
```

#🐟 Recommended Shell: Fish

For the smoothest terminal experience (fast auto-suggestions and clean syntax), Fish shell is recommended.
Setting up Fish as default:
Bash

# 1. Install Fish (if not installed)
```
sudo pacman -S fish
```
# 2. Change default shell to Fish
```
chsh -s $(which fish)
```
# 3. Disable the welcome greeting
```
fish -c "set -U fish_greeting ''"
```
