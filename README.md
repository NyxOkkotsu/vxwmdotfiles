# NyxDot 🪐

Welcome to my personal **vxwm** desktop environment configuration and dotfiles. This repository contains a complete suite of minimal, high-performance, and color-synchronized X11 desktop configurations driven by Pywal.

---

## ⚠️ Important Warning
> [!IMPORTANT]
> **The automatic installer only works on Arch Linux.** 
> Running the installation script on other distributions will result in failure due to package manager dependencies (`pacman`).

---

## 📸 Preview

![Preview 1](2026-06-25-011928_1920x1080_scrot.png)

![Preview 2](2026-06-25-074157_1695x725_scrot.png)

---

## 🚀 Key Features
* **Window Manager:** Custom optimized `vxwm` build.
* **Dynamic Colors:** Automatic theme synchronization across components using `pywal` (Dark Rasi).
* **Minimalist App Launcher:** Ultra-clean `rofi` menu without unnecessary banners or headers.
* **Notification System:** Stack-prevented `dunst` engine that refreshes brightness and volume levels in a single persistent pop-up.
* **System Styling:** Automatically applies the elegant `Graphite-Dark` GTK Theme upon installation.

---

## 📦 Core Dependencies
The `install.sh` script handles the installation of these core system utilities automatically:
* `libx11`, `libxft`, `libxinerama`, `make`
* `kitty` (Terminal Emulator)
* `thunar` (File Manager)
* `dunst` (Notification Daemon)
* `picom` (Compositor)
* `rofi` (Application Menu)
* `fish` (Shell Environment)
* `lxappearance`, `scrot`, `xwallpaper`, `pamixer`, `brightnessctl`

---

## 🛠️ How to Install

Follow these simple steps to deploy the entire configuration onto your fresh Arch Linux environment:

### 1. Just Run This
```fish
git clone https://github.com/Wahidiningrat/vxwmdotfiles
cd vxwmdotfiles
chmod +x install.sh
./install.sh
