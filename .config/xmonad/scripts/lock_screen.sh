#!/bin/bash

betterlockscreen -l dim -- --nofork \
    --ind-pos="x+w/2:y+h/2" \
    --time-pos="+150:h-200" \
    --date-pos="+150:h-150" \
    --greeter-pos="+150:h-150" \
    --time-align=1 \
    --date-align=1 \
    --greeter-align=1 \
    --time-size=120 \
    --date-size=30 \
    --greeter-size=30
