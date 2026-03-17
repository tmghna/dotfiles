#!/bin/bash

# Give background apps the map to your audio server
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# Play the sound using paplay
paplay ~/.config/dunst/padded_ping.wav
