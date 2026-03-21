#!/bin/bash

# --- SPEAKER LOGIC ---
if [ "$1" = "speaker" ]; then
    vol_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)

    # Extract the decimal (e.g., 0.45) and multiply by 100
    vol_level=$(echo "$vol_info" | awk '{print $2}')
    vol_pct=$(awk "BEGIN {print int($vol_level * 100)}")

    # Inspect the default sink to see if it's a headphone/bluetooth device
    if wpctl inspect @DEFAULT_AUDIO_SINK@ | grep -iqE 'headphone|headset|earbud|bluez'; then
        icon_active="󰋋" # md-headphones
        icon_muted="󰟎"  # md-headset_off
    else
        icon_active="󰕾" # md-volume_high
        icon_muted="󰝟"  # md-volume_off
    fi

    if echo "$vol_info" | grep -q "\[MUTED\]"; then
        # Strikethrough/Muted Icon in Red
        echo "<fc=#F38BA8>${icon_muted} </fc>${vol_pct}%"
    else
        # Active Icon in Mauve
        echo "<fc=#CBA6F7>${icon_active} </fc>${vol_pct}%"
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
