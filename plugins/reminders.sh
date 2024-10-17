#!/bin/bash

REMINDERS_COUNT=$(osascript -l JavaScript -e "Application('Reminders').reminders.whose({completed: false}).name().length")
echo "REMINDERS_COUNT: $REMINDERS_COUNT" >> ~/aaaa
sketchybar -m --set reminders icon="􀷾" \
              --set reminders label="$REMINDERS_COUNT"
