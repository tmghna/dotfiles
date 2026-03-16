module Custom.Variables where

import XMonad

-- Set Super/Windows key as the main modifier
myModMask :: KeyMask
myModMask = mod4Mask

-- Define your default terminal
myTerminal :: String
myTerminal = "wezterm"

-- Define border width
myBorderWidth :: Dimension
myBorderWidth = 2

-- Border colors
myNormalBorderColor :: String
myNormalBorderColor = "#1e1e2e"     -- Muted dark blue/grey for inactive windows

myFocusedBorderColor :: String
myFocusedBorderColor = "#cba6f7"    -- Cyan/blue glow for the active window
