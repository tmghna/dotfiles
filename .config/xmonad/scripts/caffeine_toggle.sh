#!/bin/bash
STATE_FILE="/tmp/caffeine_mode"

if [ -f "$STATE_FILE" ]; then
    # It is ON. Turn it OFF (Allow sleep)
    rm "$STATE_FILE"
    xautolock -enable
else
    # It is OFF. Turn it ON (Prevent sleep)
    touch "$STATE_FILE"
    xautolock -disable
fi
