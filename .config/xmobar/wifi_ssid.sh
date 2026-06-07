#!/bin/bash

# 1. Find the active default network interface (e.g., eno1, eth0, wlan0)
INTERFACE=$(ip route | awk '/^default/ {print $5; exit}')

# 2. Check if the active interface starts with 'e' (Ethernet)
if [[ "$INTERFACE" == e* ]]; then
  # Ethernet Connected: Green Wired Icon
  echo "<fc=#a6e3a1><fn=1>󰈀</fn> </fc>Wired"
else
  # 3. If not Ethernet, fall back to your existing Wi-Fi logic
  ssid=$(nmcli -t -f active,ssid dev wifi | awk -F: '/^yes/ {print $2}')

  if [ -z "$ssid" ]; then
    # Disconnected: Red No-WiFi Icon, no SSID
    echo "<fc=#f38ba8><fn=1>󰖪</fn></fc> "
  else
    # 4. Truncate SSID if it is longer than 12 characters
    if [ "${#ssid}" -gt 12 ]; then
      ssid="${ssid:0:12}..."
    fi
    # Connected: Green WiFi Icon + SSID
    echo "<fc=#a6e3a1><fn=1>󰖩</fn> </fc>$ssid"
  fi
fi
