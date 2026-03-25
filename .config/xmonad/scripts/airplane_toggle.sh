#!/bin/bash

# Wait a split second so the kernel has time to update the hardware state
sleep 1

# Ask NetworkManager exactly what the Wi-Fi state is
WIFI_STATE=$(nmcli -t -f WIFI radio)

if [ "$WIFI_STATE" = "disabled" ]; then
    # Sends a CRITICAL notification (Red background, stays on screen longer)
    notify-send -u critical "✈  AIRPLANE MODE ON" "Network and Bluetooth are blocked."
else
    # Sends a NORMAL notification
    notify-send -u normal "✈  AIRPLANE MODE OFF" "Network and Bluetooth restored."
fi
