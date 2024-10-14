#!/bin/bash

# Load colors and other configurations if necessary
source "$CONFIG_DIR/colors.sh"

# $1 is the workspace ID passed to the script
WORKSPACE_ID=$1

# Check if the workspace is the currently active one
CURRENT_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$WORKSPACE_ID" = "$CURRENT_WORKSPACE" ]; then
  # If the workspace is active, highlight it by turning the background on
  sketchybar --set space.$WORKSPACE_ID background.drawing=on \
                                background.color=$ACCENT_COLOR \
                                label.color=$BAR_COLOR \
                                icon.color=$BAR_COLOR
else
  # If the workspace is inactive, turn off the background
  sketchybar --set space.$WORKSPACE_ID background.drawing=off \
                                label.color=$ACCENT_COLOR \
                                icon.color=$ACCENT_COLOR
fi
