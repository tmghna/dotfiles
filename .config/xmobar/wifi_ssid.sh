#!/bin/bash

# 1. Find the active default network interface (e.g., eno1, eth0, wlan0)
INTERFACE=$(ip route | awk '/^default/ {print $5; exit}')

# 2. Check if the active interface starts with 'e' (Ethernet)
if [[ "$INTERFACE" == e* ]]; then
    # Ethernet Connected: Green Wired Icon
    echo "<fc=#a6e3a1>󰈀 </fc>Wired"
else
    # 3. If not Ethernet, fall back to your existing Wi-Fi logic
    ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '/^yes/ {print $2}')

    if [ -z "$ssid" ]; then
        # Disconnected: Red No-WiFi Icon, no SSID
        echo "<fc=#f38ba8>󰖪</fc> "
    else
        # Connected: Green WiFi Icon + SSID
        echo "<fc=#a6e3a1>󰖩 </fc>$ssid"
    fi
fi
