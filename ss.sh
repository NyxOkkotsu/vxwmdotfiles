#!/bin/bash

# Target files             
DIR="$HOME/Pictures/Screenshot"
mkdir -p "$DIR"

# File format: dd-mm-yyyy_HH-MM-SS.png
FILE="$DIR/$(date +%d-%m-%Y_%H-%M-%S).png"

# Run scrot                                       
scrot -s "$FILE"

# send notification                                                                            
if [ -f "$FILE" ]; then
    # Done                                                        
    notify-send -a "Screenshot" -i "$FILE" "Screenshots Taken" "Disimpan di: $(basename "$FILE")"
fi
