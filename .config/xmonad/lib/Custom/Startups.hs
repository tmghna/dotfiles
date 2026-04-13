module Custom.Startups (myStartupHook) where

import XMonad
import XMonad.Util.SpawnOnce (spawnOnce)

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "feh --bg-fill /home/tdey/Pictures/Wallpaper/Vinland-color.png"
    spawnOnce "dunst"
    spawnOnce "setxkbmap us"
    spawnOnce "picom -b"
    spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    spawnOnce "~/.config/xmonad/scripts/battery_alert.sh"
    spawnOnce "greenclip daemon"
    spawnOnce "touchegg"
    spawnOnce "xss-lock --transfer-sleep-lock -- /home/tdey/.config/xmonad/scripts/lock_screen.sh"
    spawnOnce "xautolock -time 5 -locker /home/tdey/.config/xmonad/scripts/lock_screen.sh"
    spawnOnce "udiskie -t &"
