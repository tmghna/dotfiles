#!/bin/bash
STATE_FILE="/tmp/caffeine_mode"

if [ -f "$STATE_FILE" ]; then
  # It is ON. Turn it OFF (Allow sleep & screen blanking)
  rm "$STATE_FILE"
  xautolock -enable
  xset s on  # Enable screensaver
  xset +dpms # Enable Display Power Management
  notify-send -u normal "☕ Caffeine" "Mode Deactivated. Normal sleep resumed."
else
  # It is OFF. Turn it ON (Prevent sleep & screen blanking)
  touch "$STATE_FILE"
  xautolock -disable
  xset s off # Disable screensaver
  xset -dpms # Disable Display Power Management
  notify-send -u normal "☕ Caffeine" "Mode Activated. Screen will stay awake."
fi
