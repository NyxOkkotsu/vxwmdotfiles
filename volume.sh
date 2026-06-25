#!/bin/bash

# Naik/turunkan volume berdasarkan argumen ($1), misal: i (up), d (down), t (toggle)
if [ "$1" = "i" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
elif [ "$1" = "d" ]; then
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
elif [ "$1" = "t" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi

# Ambil status volume saat ini
VOL=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

if echo "$VOL" | grep -q "MUTED"; then
    # Jika di-mute
    dunstify -r 9993 -a "Volume" "Volume: MUTED" -h string:x-dunst-stack-tag:volume
else
    # Jika tidak di-mute, bersihkan string buat ngambil angka persennya aja
    VOL_NUM=$(echo "$VOL" | awk '{print int($2*100)}')
    # Kirim notif dengan progress bar (-h int:value) dan ID tetap (-r 9993)
    dunstify -r 9993 -a "Volume" "Volume: $VOL_NUM%" -h int:value:"$VOL_NUM" -h string:x-dunst-stack-tag:volume
fi
