#! /usr/bin/env bash

find_chrome() {
    for chrome in google-chrome chrome chromium google-chrome-stable brave brave-browser; do
        if command -v "$chrome" &> /dev/null; then
            echo "$chrome"
            return 0
        fi
    done
    
    # Fallback: look for Chrome in common locations
    for path in /usr/bin/google-chrome /usr/bin/chromium /opt/google/chrome/chrome /usr/bin/brave; do
        if [ -x "$path" ]; then
            echo "$path"
            return 0
        fi
    done
    
    echo "Error: Chrome/Chromium/Brave not found" >&2
    exit 1
}

launch_app() {
    local app_name="$1"
    local url="$2"
    local workspace="$3"
    local chrome_bin=$(find_chrome)
    
    echo "Launching $app_name..."
    
    # Switch to the correct workspace first
    if [ -n "$workspace" ]; then
        hyprctl dispatch workspace "$workspace"
    fi
    
    exec setsid "$chrome_bin" \
        --app="$url" \
        --enable-features=WebAppEnableExtensions,UseOzonePlatform \
        --ozone-platform=wayland \
        --disable-features=WaylandWpColorManagerV1 \
        --enable-wayland-ime \
        --no-first-run \
        --no-default-browser-check > /dev/null 2>&1 &
}

case "$1" in
    gmail)
        launch_app "Gmail" "https://mail.google.com" 8
        ;;
    discord)
        launch_app "Discord" "https://discord.com/app" 7
        ;;
    whatsapp)
        launch_app "WhatsApp" "https://web.whatsapp.com" 7
        ;;
    spotify)
        launch_app "Spotify" "https://open.spotify.com" 10
        ;;
    teams)
        launch_app "Teams" "https://teams.microsoft.com" 9
        ;;
    outlook)
        launch_app "Outlook" "https://outlook.office.com" 8
        ;;
    claude)
        launch_app "Claude" "https://claude.ai" 5
        ;;
    chatgpt)
        launch_app "ChatGPT" "https://chatgpt.com" 5
        ;;
    gemini)
        launch_app "Gemini" "https://gemini.google.com" 5
        ;;
    copilot)
        launch_app "Copilot" "https://copilot.microsoft.com" 5
        ;;
    *)
        echo "Usage: $0 {gmail|discord|whatsapp|youtube|spotify|teams|outlook|claude|chatgpt|gemini|copilot}"
        exit 1
        ;;
esac
