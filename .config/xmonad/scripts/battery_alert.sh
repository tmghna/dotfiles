#!/bin/bash

# Grab the initial status before the loop starts
prev_status=$(cat /sys/class/power_supply/BAT*/status | head -n 1)
low_battery_notified=0

while true; do
    battery_level=$(cat /sys/class/power_supply/BAT*/capacity | head -n 1)
    battery_status=$(cat /sys/class/power_supply/BAT*/status | head -n 1)

    # 1. Check if the charger was just plugged in or unplugged
    if [ "$battery_status" != "$prev_status" ]; then
        if [ "$battery_status" = "Charging" ]; then
            notify-send -u normal "Power Restored" "Charger plugged in. ($battery_level%)"
            
            # Reset the low battery warning flag since we are charging
            low_battery_notified=0 
            
        elif [ "$battery_status" = "Discharging" ]; then
            notify-send -u normal "Power Disconnected" "Running on battery. ($battery_level%)"
        fi
        
        # Update the previous status to the new one
        prev_status=$battery_status
    fi

    # 2. Check for low battery (Below 30%, discharging, and hasn't warned you yet)
    if [ "$battery_status" = "Discharging" ] && [ "$battery_level" -le 30 ] && [ "$low_battery_notified" -eq 0 ]; then
        notify-send -u critical "Battery Low" "Plug in your charger! ($battery_level%)"
        
        # Set the flag to 1 so it doesn't spam you every 5 seconds
        low_battery_notified=1
    fi

    # Sleep for 3 seconds for responsive plug/unplug detection
    sleep 3
done
