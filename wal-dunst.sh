#!/bin/bash

# 1. Ambil variabel warna dari .cache/wal kamu
source "$HOME/.cache/wal/colors.sh"

# 2. Buat file config dunst langsung dengan warna yang pas
mkdir -p "$HOME/.config/dunst"
cat <<EOF > "$HOME/.config/dunst/dunstrc"
[global]
    monitor = 0
    follow = mouse
    width = 300
    height = 200
    origin = top-right
    offset = 10x50
    scale = 0
    notification_limit = 0

    font = Monospace 10
    line_height = 0
    format = "<b>%s</b>\n%b"
    alignment = left
    word_wrap = yes
    stack_duplicates = true

    frame_width = 3
    separator_height = 2
    padding = 8
    horizontal_padding = 8
    separator_color = frame

[urgency_low]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color4"
    timeout = 10

[urgency_normal]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color2"
    timeout = 10

[urgency_critical]
    background = "$background"
    foreground = "$foreground"
    frame_color = "$color1"
    timeout = 0
EOF

# 3. Restart Dunst agar langsung pakai config baru
killall dunst
dunst &
