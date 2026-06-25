# NyxDot 🪐

Welcome to my personal **vxwm** desktop environment configuration and dotfiles. This repository contains a complete suite of minimal, high-performance, and color-synchronized X11 desktop configurations driven by Pywal.

---

## ⚠️ Important Warning
> [!IMPORTANT]
> **The automatic installer only works on Arch Linux.** 
> Running the installation script on other distributions will result in failure due to package manager dependencies (`pacman`).

---

## 📸 Preview

No Preview 

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

### 1. Clone the Repository
```fish
git clone [https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git](https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME.git)
cd YOUR_REPO_NAME
chmod +x install.sh
./install.sh
