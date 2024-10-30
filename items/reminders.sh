#!/bin/bash

reminders_settings=(
  update_freq=20
  script="~/.config/sketchybar/plugins/reminders.sh" 
  click_script="~/.config/sketchybar/plugins/reminders_click.sh"
)

sketchybar -m --add item reminders right \
              --set reminders "${reminders_settings[@]}"

