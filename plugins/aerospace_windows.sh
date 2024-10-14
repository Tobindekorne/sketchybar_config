#!/bin/bash

# Define the workspace IDs you want to map
workspace_apps_map=(
  "B:Google Chrome,Firefox"
  "C:Telegram,Messages"
  "E:Finder"
  "M:Spotify"
  "O:Obsidian"
  "T:WezTerm"
  "V:Code"
)

# Get the list of windows from aerospace
windows=$(aerospace list-windows --all)

# Iterate over each workspace in the map
for workspace_entry in "${workspace_apps_map[@]}"; do
  # Split workspace ID and app list
  IFS=":" read -r workspace_id apps_list <<< "$workspace_entry"
  IFS="," read -r -a apps_array <<< "$apps_list"

  icon_strip=" "
  # Iterate over each app in the list
  for app in "${apps_array[@]}"; do
    # Check if the app is in the window list
    if echo "$windows" | grep -q "$app"; then
      icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
    fi
  done

  if [ "$icon_strip" = " " ]; then
    icon_strip=" —"
  fi

  # Update the workspace label with the apps and workspace letter
  # sketchybar --set space.$workspace_id label="$workspace_id $icon_strip"
  # sketchybar --set space.$workspace_id label="$workspace_id " icon="$($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
  sketchybar --set space.$workspace_id label="$workspace_id $icon_strip"
done

