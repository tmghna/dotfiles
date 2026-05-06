#!/bin/bash

# Give background apps the map to your audio server
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export DBUS_SESSION_BUS_ADDRESS="unix:path=${XDG_RUNTIME_DIR}/bus"

# Define the sound file path
SOUND_FILE="$HOME/.config/dunst/padded_ping.wav"

# TARGETED DEBOUNCE:
# Only exit if the SPECIFIC notification sound is already being played by mpv.
# This allows you to watch movies in mpv while still hearing notifications.
if pgrep -f "mpv.*padded_ping.wav" >/dev/null; then
  exit 0
fi

# --no-config: Ignore your ~/.config/mpv/mpv.conf for faster startup/exit.
# --idle=no: Force immediate exit after the sound ends.
/usr/bin/mpv --no-config --no-video --really-quiet --idle=no "$SOUND_FILE"
