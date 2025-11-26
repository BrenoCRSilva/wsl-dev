#!/bin/bash
wallpaper_dir="$HOME/.config/wallpapers"

choice=$({
    ls "$wallpaper_dir"/*.{jpg,png,jpeg} 2>/dev/null | xargs -n1 basename
    echo "Exit"
} | wofi --dmenu --conf "$HOME/.config/wofi/wpp-config" --prompt "Select Wallpaper")

case $choice in
    "Exit")
        exit 0
        ;;
    *)
        imv "$wallpaper_dir/$choice" &
        imv_pid=$!
        
        confirm=$(echo -e "Apply\nBack" | wofi --dmenu --conf "$HOME/.config/wofi/confirm-config" --prompt "Apply this wallpaper?")
        
        kill $imv_pid 2>/dev/null
        
        case $confirm in
            "Apply")
                echo "Applying wallpaper: $choice"
                hyprctl hyprpaper unload all > /dev/null 2>&1
                hyprctl hyprpaper preload "$wallpaper_dir/$choice" > /dev/null 2>&1
                hyprctl hyprpaper wallpaper "DP-3,$wallpaper_dir/$choice" > /dev/null 2>&1
                hyprctl hyprpaper wallpaper "$wallpaper_dir/$choice" > /dev/null 2>&1
                
                # Optional: Show success notification
                notify-send "Wallpaper Applied" "$choice" 2>/dev/null
                ;;
            "Back")
                echo "Going back to wallpaper selection..."
                exec "$0"
                ;;
        esac
        ;;
esac
