#!/bin/bash

# Fetch the active SSID
ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '/^yes/ {print $2}')

# Check if the string is empty
if [ -z "$ssid" ]; then
    # Disconnected: Red No-WiFi Icon, no SSID
    echo "<fc=#f38ba8>󰖪</fc> "
else
    # Connected: Green WiFi Icon + SSID
    echo "<fc=#a6e3a1>󰖩 </fc>$ssid"
fi
