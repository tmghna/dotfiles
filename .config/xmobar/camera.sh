#!/bin/bash

# Query the camera for the hardware privacy flag
# 2>/dev/null hides the output if the camera is completely missing
PRIVACY_STATUS=$(v4l2-ctl --get-ctrl=privacy 2>/dev/null)

if [[ "$PRIVACY_STATUS" == *"privacy: 1"* ]]; then
    # Shutter is CLOSED (Red Strikethrough)
    echo "<fc=#f38ba8>󰄀</fc>"
elif [[ "$PRIVACY_STATUS" == *"privacy: 0"* ]]; then
    # Shutter is OPEN (Green Icon)
    echo "<fc=#f9e2af>󰄀</fc>"
else
    # Fallback: If the camera doesn't support the privacy flag, 
    # fallback to checking if the device file exists at all.
    if ls /dev/video* 1> /dev/null 2>&1; then
        echo "<fc=#f9e2af>󰄀</fc>"
    else
        echo "<fc=#f38ba8>󰄀</fc>"
    fi
fi
