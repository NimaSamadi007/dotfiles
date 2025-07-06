#!/bin/bash

# Folder containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/bgs"

# Get list of available images
images=("$WALLPAPER_DIR"/*)

# Get connected monitors
monitors=($(xrandr --query | grep " connected" | cut -d" " -f1))

# Randomly shuffle the images
shuffled=($(shuf -e "${images[@]}"))

# Create feh command
feh_cmd="feh --no-fehbg --bg-scale"

# Apply wallpapers per monitor
for i in "${!monitors[@]}"; do
    wallpaper="${shuffled[$i]}"
    [[ -f "$wallpaper" ]] && feh_cmd="$feh_cmd \"$wallpaper\""
done

# Run the command
eval "$feh_cmd"

