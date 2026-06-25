#!/bin/bash

# Naik/turunkan brightness berdasarkan argumen, misal: +5% atau 5%-
brightnessctl set "$1"

# Ambil nilai persentase kecerahan saat ini
BRIGHT=$(brightnessctl i | grep -oP '\(\K[^)]+(?=\%)')

# Kirim notif dengan progress bar dan ID tetap (-r 9994)
dunstify -r 9994 -a "Brightness" "Brightness: $BRIGHT%" -h int:value:"$BRIGHT" -h string:x-dunst-stack-tag:brightness
