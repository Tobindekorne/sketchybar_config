#!/bin/bash

REMINDERS_COUNT=$(osascript -l JavaScript -e "Application('Reminders').reminders.whose({completed: false}).name().length")
sketchybar -m --set reminders icon="􀷾" \
              --set reminders label="$REMINDERS_COUNT"
