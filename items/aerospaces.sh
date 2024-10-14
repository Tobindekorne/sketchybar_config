#!/bin/bash

# Define the workspace IDs you want to use
SPACE_SIDS=(B C E M O T V)

for sid in "${SPACE_SIDS[@]}"
do
  sketchybar --add space space.$sid left                                 \
             --set space.$sid space=$sid                                 \
                              icon=$sid                                  \
                              label.font="sketchybar-app-font:Regular:16.0" \
                              label.padding_right=20                     \
                              label.y_offset=-1                          \
                              script="$PLUGIN_DIR/aerospace.sh"
done

# Adding a space separator
sketchybar --add item space_separator left                             \
           --set space_separator icon="􀆊"                                \
                                 icon.color=$ACCENT_COLOR \
                                 icon.padding_left=4                   \
                                 label.drawing=off                     \
                                 background.drawing=off                \
                                 script="$PLUGIN_DIR/aerospace_windows.sh" \
           --subscribe space_separator aerospace_workspace_change
