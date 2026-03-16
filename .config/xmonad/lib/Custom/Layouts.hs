module Custom.Layouts where

import XMonad
import XMonad.Layout.ResizableTile
import XMonad.Layout.Spacing

-- NEW IMPORT: Tells Xmonad to avoid drawing under the status bar
import XMonad.Hooks.ManageDocks (avoidStruts)

-- spacingRaw Args: SmartBorder(False), ScreenGap, ScreenGapEnabled, WindowGap, WindowGapEnabled
myGaps = spacingRaw False (Border 5 5 5 5) True (Border 10 10 10 10) True

 
-- ResizableTall arguments:
-- 1 = default number of master windows
-- 3/100 = percentage to resize horizontally
-- 1/2 = initial split size
-- [] = slave vertical fractions
myLayouts = myGaps (ResizableTall 1 (3/100) (1/2) []) ||| myGaps Full
