#!/bin/bash

# --- SPEAKER LOGIC ---
if [ "$1" = "speaker" ]; then
    vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

    # Extract the decimal (e.g., 0.45) and multiply by 100
    vol_level=$(echo "$vol_info" | awk '{print $2}')
    vol_pct=$(awk "BEGIN {print int($vol_level * 100)}")

    if echo "$vol_info" | grep -q "\[MUTED\]"; then
        # Strikethrough Speaker in Red, keeping the percentage visible
        echo "<fc=#F38BA8>󰝟 </fc> ${vol_pct}%"
    else
        # Active Speaker in Mauve
        echo "<fc=#CBA6F7>󰕾 </fc> ${vol_pct}%"
    fi

# --- MICROPHONE LOGIC ---
elif [ "$1" = "mic" ]; then
    mic_info=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)

    if echo "$mic_info" | grep -q "\[MUTED\]"; then
        # Strikethrough Mic in Red (No text, just the icon)
        echo "<fc=#F38BA8></fc>"
    else
        # Active Mic in Mauve (No text, just the icon)
        echo "<fc=#FAB387></fc>"
    fi
fi
