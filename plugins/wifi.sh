#!/bin/sh

# SSID=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | awk -F:  '($1 ~ "^ *SSID$"){print $2}' | cut -c 2-)

# sketchybar --set wifi \
#   icon= icon.color=0xff58d1fc \
#   label="$SSID"

CURRENT_WIFI="$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I)"
SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID: .*" | sed 's/^SSID: //')"
CURR_TX="$(echo "$CURRENT_WIFI" | grep -o "lastTxRate: .*" | sed 's/^lastTxRate: //')"
echo $CURR_TX >> ~/aaaa
POPUP_OFF="sketchybar --set wifi.control popup.drawing=off"
POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

# # Scan for available Wi-Fi networks using the airport command (macOS)
# scan_wifi_networks() {
#   networks=$( /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s | tail -n +2 | awk '{print $1}' )
#   echo "$networks"
# }

# # Function to handle Wi-Fi connection
# connect_to_wifi() {
#   NETWORK_NAME=$1
#   PASSWORD=$2
#   echo "Connecting to $NETWORK_NAME..."
#   # Use networksetup for macOS to connect to Wi-Fi
#   # Replace YOUR_INTERFACE with the correct network interface (e.g., en0)
#   networksetup -setairportnetwork YOUR_INTERFACE "$NETWORK_NAME" "$PASSWORD"
# }

# # Show the dropdown menu with available Wi-Fi networks
# wifi_dropdown() {
#   sketchybar --remove "/wifi_dropdown.*/"
#   available_networks=$(scan_wifi_networks)

#   for NETWORK in $available_networks; do
#     sketchybar --add item wifi_dropdown.$NETWORK popup.wifi_icon \
#                --set wifi_dropdown.$NETWORK label="$NETWORK" \
#                click_script="~/.config/sketchybar/plugins/wifi.sh mouse_clicked $NETWORK"
#   done
# }

# # Handle mouse clicks on Wi-Fi options
# mouse_clicked() {
#   NETWORK_NAME=$1
#   echo "Selected network: $NETWORK_NAME"
#   # Prompt for password input
#   PASSWORD=$(osascript -e 'Tell application "System Events" to display dialog "Enter Wi-Fi Password" default answer "" with hidden answer' -e 'text returned of result')
#   connect_to_wifi "$NETWORK_NAME" "$PASSWORD"
# }

# # Event handling
# case "$SENDER" in
#   "mouse.clicked") wifi_dropdown ;;
#   "wifi_connect") mouse_clicked "$INFO" ;;
# esac

