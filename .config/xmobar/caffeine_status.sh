#!/bin/bash
STATE_FILE="/tmp/caffeine_mode"

if [ -f "$STATE_FILE" ]; then
    # Caffeine ON
    echo "<fc=#fab387>  </fc>"
else
    # Caffeine OFF
    echo "<fc=#cdd6f4>  </fc>"
fi
