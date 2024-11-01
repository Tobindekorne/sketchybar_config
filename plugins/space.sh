#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

update() {
  # To work only on initial startup
  # Currently forced and space_change events are occurring simultaneously.
  if [ "$SENDER" = "space_change" ]; then
    # echo space.sh $'FOCUSED_WORKSPACE': $FOCUSED_WORKSPACE, $'SELECTED': $SELECTED, NAME: $NAME, SENDER: $SENDER, INFO: $INFO  >> ~/aaaa
    #echo $(aerospace list-workspaces --focused) >> ~/aaaa
    source "$CONFIG_DIR/colors.sh"

    FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused | tr -d '\n')
    BLURRED_WORKSPACES=$(aerospace list-workspaces --all | grep -v "$FOCUSED_WORKSPACE")

    # This sets the style for the currently selected space in the list of spaces
    sketchybar --set space.$FOCUSED_WORKSPACE icon.highlight=off \
                      label.color=$ACCENT_COLOR \
                      icon.color=$ACCENT_COLOR \
                      background.border_color=$ACCENT_COLOR \
                      background.color=$FOCUSED_SPACE_BG_COLOR

    # Now let's style each of the unselected workspaces
    for w in $BLURRED_WORKSPACES; do
      sketchybar --set space.$w icon.highlight=false \
                         label.highlight=false \
                         label.color=$BLURRED_SPACE_FG_COLOR \
                         icon.color=$BLURRED_SPACE_FG_COLOR \
                         background.border_color=$BLURRED_SPACE_BG_COLOR \
                         background.color=$BLURRED_SPACE_BG_COLOR
    done
  fi
}

set_space_label() {
  sketchybar --set $NAME icon="$@"
}

mouse_clicked() {
  if [ "$BUTTON" = "right" ]; then
    echo ''
  else
    if [ "$MODIFIER" = "shift" ]; then
      SPACE_LABEL="$(osascript -e "return (text returned of (display dialog \"Give a name to space $NAME:\" default answer \"\" with icon note buttons {\"Cancel\", \"Continue\"} default button \"Continue\"))")"
      if [ $? -eq 0 ]; then
        if [ "$SPACE_LABEL" = "" ]; then
          set_space_label "${NAME:6}"
        else
          set_space_label "${NAME:6} ($SPACE_LABEL)"
        fi
      fi
    else
      #echo space.sh BUTTON: $BUTTON, $'SELECTED': $SELECTED, MODIFIER: $MODIFIER, NAME: $NAME, SENDER: $SENDER, INFO: $INFO, TEST: ${NAME#*.}, ${NAME:6} >> ~/aaaa
      aerospace workspace ${NAME#*.}
    fi
  fi
}

# echo plugin_space.sh $SENDER >> ~/aaaa
case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  *) update
  ;;
esac
