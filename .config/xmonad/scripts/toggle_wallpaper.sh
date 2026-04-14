#!/bin/bash

# A temporary file to remember which workspace you were on
STATE_FILE="/tmp/xmonad_last_ws"

# Get the current workspace number (wmctrl is 0-indexed)
current_ws=$(wmctrl -d | grep '\*' | awk '{print $1}')

# Check if there are any windows on the current workspace
# (Ignores your xmobar/docks because wmctrl lists them on workspace "-1")
windows_on_current=$(wmctrl -l | awk -v ws="$current_ws" '$2 == ws')

if [ -z "$windows_on_current" ]; then
    # If the current workspace is empty, jump back to the saved workspace
    if [ -f "$STATE_FILE" ]; then
        last_ws=$(cat "$STATE_FILE")
        wmctrl -s "$last_ws"
    fi
else
    # If there are windows, save this workspace so we can return later
    echo "$current_ws" > "$STATE_FILE"
    
    # Get total number of workspaces
    total_ws=$(wmctrl -d | wc -l)
    
    # Loop through all workspaces to find the first empty one
    for (( i=0; i<$total_ws; i++ )); do
        if ! wmctrl -l | awk '{print $2}' | grep -qw "$i"; then
            # Found an empty workspace! Switch to it and exit
            wmctrl -s "$i"
            exit 0
        fi
    done
fi
