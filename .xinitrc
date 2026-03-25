#!/bin/sh

prefix="/usr"
exec_prefix="${prefix}"
xrdb="xrdb"
xinitdir="/etc/X11/xinit"
xterm="xterm"
xmodmap="xmodmap"

userresources="$HOME/.Xresources"
usermodmap="$HOME/.Xmodmap"
sysresources="$xinitdir/.Xresources"
sysmodmap="$xinitdir/.Xmodmap"

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$sysresources"
    else
        "$xrdb" -nocpp -merge "$sysresources"
    fi
fi

if [ -f "$sysmodmap" ]; then
    "$xmodmap" "$sysmodmap"
fi

if [ -f "$userresources" ]; then
    if [ -x /usr/bin/cpp ] ; then
        "$xrdb" -merge "$userresources"
    else
        "$xrdb" -nocpp -merge "$userresources"
    fi
fi

if [ -f "$usermodmap" ]; then
    "$xmodmap" "$usermodmap"
fi

# start some nice programs

if [ -d "$xinitdir"/xinitrc.d ] ; then
	for f in "$xinitdir/xinitrc.d"/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

feh --bg-fill /home/tdey/Pictures/Wallpaper/Vinland-color.png &
dunst &
setxkbmap us &

picom -b &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
~/.config/xmonad/scripts/battery_alert.sh &
greenclip daemon &
touchegg &

# Auto-lock after 5 mins of inactivity
xautolock -time 5 -locker "/home/tdey/.config/xmonad/scripts/lock_screen.sh" &
# Lock screen immediately when suspended
xss-lock --transfer-sleep-lock -- /home/tdey/.config/xmonad/scripts/lock_screen.sh &

export QT_QPA_PLATFORMTHEME="gtk3"
export NEWT_COLORS="root=default,default;window=default,default;border=magenta,default;textbox=white,default;button=black,magenta;listbox=white,default;sellistbox=black,magenta;actsellistbox=black,magenta;title=magenta,default;checkbox=magenta,default;actcheckbox=black,magenta;label=white,default;entry=magenta,default"
exec xmonad
