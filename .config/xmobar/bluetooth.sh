#!/bin/bash

# Check if Bluetooth is powered on
if bluetoothctl show | grep -q "Powered: yes"; then
    # Active: Blue Bluetooth Logo
    echo "<fc=#89b4fa>󰂯</fc>"
else
    # Inactive: Red Strikethrough Logo
    echo "<fc=#f38ba8>󰂲</fc>"
fi
