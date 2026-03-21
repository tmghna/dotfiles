module Custom.Keybindings where

import XMonad
import Custom.Variables (myTerminal)

-- Import for vertical resizing
import XMonad.Layout.ResizableTile (MirrorResize(..))
-- Import for Cycling through windows
import XMonad.Actions.CycleWS
-- Import for floating window control
import XMonad.Actions.FloatKeys
import qualified XMonad.StackSet as W

-- This defines the list of keybindings to be added
myKeys :: [(String, X ())]
myKeys =
    [ ("M-<Return>", spawn myTerminal)                                 -- Super + Enter: Wezterm
    , ("M-<Space>", spawn "rofi -show drun")                           -- Super + Space:  Rofi
    , ("M-.", spawn "rofi -modi emoji -show emoji -emoji-mode insert -theme ~/.config/rofi/emoji.rasi -emoji-format '{emoji}'")      -- Super + . Rofi emoji picker
    , ("M-v", spawn "~/.config/xmonad/scripts/smart_paste.sh")         -- Super + v: Clipbaord History Manager
    , ("M-z", spawn "wezterm start -- yazi ~")                         -- Launch yazi in new terminal at home
    , ("M-<Tab>", sendMessage NextLayout)                              -- Move Layout cycling to Super + Tab
    , ("M-<Escape>", spawn "xautolock -locknow")                       -- Super + Esc: Lock screen
    , ("M-S-<Escape>", spawn "systemctl poweroff")                     -- Super + Shift + Esc: Shutdown
    , ("M-n", spawn "wezterm start --class nmtui-floating -- nmtui")   -- Launch nmtui
    , ("M-<R>", nextWS)                                                -- Next Workspace
    , ("M-<L>",  prevWS)                                               -- Previous Workspace
    , ("M--", withFocused (keysResizeWindow (-40, -40) (1/2, 1/2)))
    , ("M-=", withFocused (keysResizeWindow (40, 40) (1/2, 1/2)))
    , ("M-S-<Return>", windows W.swapMaster)
    , ("M-S-b", spawn "blueman-manager")
    , ("M-c", spawn "/home/tdey/.config/xmonad/scripts/caffeine_toggle.sh")

    -- Volume Controls (Using WirePlumber)
    , ("<XF86AudioRaiseVolume>", spawn "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+")
    , ("<XF86AudioLowerVolume>", spawn "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-")
    , ("<XF86AudioMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
    , ("<XF86AudioMicMute>", spawn "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")

    -- Brightness Controls (Using brightnessctl)
    , ("<XF86MonBrightnessUp>", spawn "brightnessctl set +1%")
    , ("<XF86MonBrightnessDown>", spawn "brightnessctl set 1%-")

    -- Media Player Controls (Using playerctl)
    , ("<XF86AudioPlay>", spawn "playerctl play-pause")
    , ("<XF86AudioNext>", spawn "playerctl next")
    , ("<XF86AudioPrev>", spawn "playerctl previous")

    -- Screenshots (Using Flameshot)
    , ("M-s", spawn "flameshot gui")             -- Super + s key
    , ("M-f", spawn "flameshot full -c")         -- Super + f to copy whole screen to clipboard 

    -- Master Pane
    , ("M-[", sendMessage (IncMasterN 1))      -- Pulls a window to the left
    , ("M-]", sendMessage (IncMasterN (-1)))   -- Pushes a window to the right

    -- Vertical Resizing 
    , ("M-u", sendMessage MirrorExpand)        -- Enlarge focused window vertically
    , ("M-i", sendMessage MirrorShrink)        -- Shrink focused window vertically
    ]
