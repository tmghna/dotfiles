#!/bin/bash

# Grab the AMD CPU Temp (stripping out the + and °C so it's just the number)
temp=$(sensors | grep "Tctl:" | awk '{print $2}' | tr -d '+' | sed 's/°C//')

# Print it formatted for Xmobar with a Catppuccin Mauve thermometer icon
echo "<fc=#f38ba8></fc>  ${temp}°C"
