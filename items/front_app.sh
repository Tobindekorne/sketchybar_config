#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       background.color=$FRONT_APP_BG \
                                 icon.color=$FRONT_APP_ICON \
                                 icon.font="sketchybar-app-font:Regular:16.0" \
                                 label.color=$FRONT_APP_LABEL \
                                 display=active \
                                 script="$PLUGIN_DIR/front_app.sh"            \
                                 click_script="open -a 'Mission Control'" \
           --subscribe front_app front_app_switched
