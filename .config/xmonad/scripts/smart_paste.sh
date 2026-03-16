#!/bin/bash

# 1. Pipe greenclip's history directly into Rofi's dmenu mode
# If you press Escape or click away, $selected will remain completely empty.
selected=$(greenclip print | rofi -dmenu -i -p "Clipboard" -theme ~/.config/rofi/clipboard.rasi)

# 2. Check if $selected actually contains text
if [ -n "$selected" ]; then
    # Push the chosen text to the system clipboard using xsel
    echo -n "$selected" | xsel -ib
    
    # Wait for Rofi to close and your window to regain focus
    sleep 0.2
    
    # Execute the paste
    xdotool key Shift+Insert
fi
