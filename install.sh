#!/bin/bash
# ==============================================================================
#  NyxDot - Automated Installer Script for vxwm & Dotfiles
# ==============================================================================
# Author: NyxFedora / Rafa

set -e # Exit immediately if a command exits with a non-zero status

# Color definitions for clean and aesthetic terminal output
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Error handling function to show the failure dialog
failure_handler() {
    echo -e "\n--------------------------------------------------------"
    echo -e "${RED}[!] Failed! Report The Script Bug To Github Issues${NC}"
    echo -e "--------------------------------------------------------\n"
}

# Trap any error and execute the failure handler
trap 'failure_handler' ERR

# Clear screen for a neat welcome interface
clear

# 1. ASCII Art & Welcome Dialog
echo -e "${PURPLE}"
cat << "EOF"
  _   _               ____       _   
 | \ | |_   ___  __  |  _ \  ___| |_ 
 |  \| \ \ / \ \/ /  | | | |/ _ \ __|
 | |\  |\ V / >  <   | |_| |  __/ |_ 
 |_| \_| \_/ /_/\_\  |____/ \___|\__|
                                     
EOF
echo -e "${CYAN}Welcome To NyxDot${NC}"
echo -e "${YELLOW}it install my personal vxwm config to ur system:3${NC}"
echo -e "--------------------------------------------------------"
echo

# 2. Sudo Privileges Escalation Check
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}[*] Root privileges required to install packages via pacman...${NC}"
    sudo -v
fi

# 3. Define Dependencies Array
DEPENDENCIES=(
    libx11 
    libxft 
    libxinerama 
    make 
    kitty 
    dunst 
    xwallpaper 
    picom 
    rofi 
    pamixer 
    brightnessctl 
    xorg-server 
    xorg-xinit 
    xterm 
    scrot
    lxappearance
    git
    base-devel
    thunar
    python-pywal
)

echo -e "${BLUE}[*] Synchronizing package databases and installing dependencies...${NC}"
sudo pacman -Sy --needed --noconfirm "${DEPENDENCIES[@]}"

echo -e "\n${GREEN}[+] All official dependencies installed successfully!${NC}\n"

# 4. Install Graphite GTK Theme from AUR
echo -e "${BLUE}[*] Building and installing graphite-gtk-theme from AUR...${NC}"
AUR_DIR="/tmp/graphite-gtk-theme"
rm -rf "$AUR_DIR"
git clone https://aur.archlinux.org/graphite-gtk-theme.git "$AUR_DIR"

# Change ownership of the temp folder so makepkg can run safely as normal user
chown -R "$(logname):$(id -gn "$(logname)")" "$AUR_DIR"

# Run makepkg as the normal user
cd "$AUR_DIR"
sudo -u "$(logname)" makepkg -si --noconfirm
cd - > /dev/null
rm -rf "$AUR_DIR"

echo -e "${GREEN}[+] Graphite GTK Theme installed successfully!${NC}\n"

# 5. Compile and Install vxwm Window Manager from 'myvxwm' folder
echo -e "${BLUE}[*] Compiling vxwm window manager from local 'myvxwm' folder...${NC}"
if [ -d "myvxwm" ] && [ -f "myvxwm/Makefile" ]; then
    cd myvxwm
    echo -e "${CYAN}Executing: sudo make clean install...${NC}"
    sudo make clean install
    cd - > /dev/null
    echo -e "${GREEN}[+] vxwm compiled and installed perfectly!${NC}\n"
else
    echo -e "\n--------------------------------------------------------"
    echo -e "${RED}[!] Error: 'myvxwm' folder or Makefile not found!${NC}"
    echo -e "--------------------------------------------------------\n"
    exit 1
fi

# 6. Prepare Target Base Directories
echo -e "${BLUE}[*] Creating required directories in user space...${NC}"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.config/dunst"
mkdir -p "$HOME/.config/gtk-3.0"
mkdir -p "$HOME/.config/gtk-4.0"
mkdir -p "$HOME/.cache"
mkdir -p "$HOME/Pictures/Screenshot"
mkdir -p "$HOME/Pictures/Wallpaper"

# 7. Apply Graphite-Dark Theme Configuration directly to GTK files
echo -e "${BLUE}[*] Applying Graphite-Dark theme settings...${NC}"
echo 'gtk-theme-name="Graphite-Dark"' > "$HOME/.gtkrc-2.0"

cat << EOF > "$HOME/.config/gtk-3.0/settings.ini"
[Settings]
gtk-theme-name=Graphite-Dark
gtk-application-prefer-dark-theme=1
EOF

cat << EOF > "$HOME/.config/gtk-4.0/settings.ini"
[Settings]
gtk-theme-name=Graphite-Dark
gtk-application-prefer-dark-theme=1
EOF

echo -e "${GREEN}[+] Theme configurations written successfully!${NC}\n"

# 8. Deploy Shell Scripts and System Files to Home (~/) with 777 Permissions
echo -e "${BLUE}[*] Deploying automation scripts to home directory (~/)...${NC}"
SCRIPTS=(
    brightness.sh 
    ss.sh 
    rofi-wallpaper.sh 
    volume.sh 
    wal-dunst.sh
)

for script in "${SCRIPTS[@]}"; do
    if [ -f "$script" ]; then
        cp "$script" "$HOME/"
        chmod 777 "$HOME/$script"
        echo -e "    -> Deployed with 777 perms: ~/$script"
    else
        echo -e "${YELLOW}    -> [Skip] Source file '$script' not found in current repository.${NC}"
    fi
done

if [ -f ".xinitrc" ]; then
    cp ".xinitrc" "$HOME/"
    echo -e "    -> Deployed: ~/.xinitrc"
else
    echo -e "${YELLOW}    -> [Skip] Source file '.xinitrc' not found.${NC}"
fi

# 9. Auto-detect and Copy Wallpapers/Images
echo -e "\n${BLUE}[*] Scanning and copying all image formats to ~/Pictures/Wallpaper...${NC}"
find . -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    ! -path "*/.git/*" ! -path "*/.config/*" ! -path "*/myvxwm/*" -exec cp {} "$HOME/Pictures/Wallpaper/" \; -print | while read -r img; do
    echo -e "    -> Discovered & Copied: $(basename "$img")"
done

# 10. Deploy Configuration Folders to ~/.config
echo -e "\n${BLUE}[*] Distributing config profiles to ~/.config/...${NC}"
CONFIGS=(
    fish 
    rofi 
    kitty 
    picom
)

for config_dir in "${CONFIGS[@]}"; do
    if [ -d "$config_dir" ]; then
        rm -rf "$HOME/.config/$config_dir"
        cp -r "$config_dir" "$HOME/.config/"
        echo -e "    -> Deployed folder: ~/.config/$config_dir"
    else
        echo -e "${YELLOW}    -> [Skip] Configuration folder '$config_dir/' not found.${NC}"
    fi
done

# Explicitly copy standalone dunstrc file to ~/.config/dunst/dunstrc
echo -e "\n${BLUE}[*] Deploying Dunst configuration file (dunstrc)...${NC}"
if [ -f "dunstrc" ]; then
    rm -f "$HOME/.config/dunst/dunstrc"
    cp "dunstrc" "$HOME/.config/dunst/dunstrc"
    echo -e "    -> Deployed file: ~/.config/dunst/dunstrc"
else
    echo -e "${YELLOW}    -> [Skip] File 'dunstrc' not found in repository root.${NC}"
fi

# 11. Deploy Pywal Cache to ~/.cache
echo -e "\n${BLUE}[*] Deploying Pywal color cache to ~/.cache/...${NC}"
if [ -d "wal" ]; then
    rm -rf "$HOME/.cache/wal"
    cp -r "wal" "$HOME/.cache/"
    echo -e "    -> Deployed: ~/.cache/wal"
elif [ -d ".cache/wal" ] ; then
    rm -rf "$HOME/.cache/wal"
    cp -r ".cache/wal" "$HOME/.cache/"
    echo -e "    -> Deployed: ~/.cache/wal"
else
    echo -e "${YELLOW}    -> [Skip] Pywal cache directory ('wal' or '.cache/wal') not found in repository.${NC}"
fi

# Finalizing Installation Profile (Success Dialog)
echo -e "\n--------------------------------------------------------"
echo -e "${GREEN}Config Applied!${NC}"
echo -e "--------------------------------------------------------\n"
