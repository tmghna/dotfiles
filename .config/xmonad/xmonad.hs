import XMonad
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as W

-- NEW: The essential module for status bars
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

import XMonad.Util.EZConfig (additionalKeysP)

-- Import custom modules
import Custom.Variables
import Custom.Keybindings
import Custom.Layouts

main :: IO ()
-- Wrap myConfig in 'docks' so Xmonad actively listens for Xmobar
main = xmonad =<< statusBar "xmobar" myXmobarPP toggleStrutsKey (docks myConfig)

-- This adds a shortcut (Super + b) to toggle the bar on and off if you want full screen
toggleStrutsKey XConfig { modMask = m } = (m, xK_b)

-- This entirely customizes the %StdinReader% output format
myXmobarPP :: PP
myXmobarPP = xmobarPP
    { ppOrder           = \(ws:l:t:_) -> [l, ws, t]
    , ppSep             = "  " 
    -- \xf012f is the Nerd Font hex for the filled dot (Mauve)
    , ppCurrent         = xmobarColor "#cba6f7" "" . const "\xf012f " 
    -- \xf0130 is the Nerd Font hex for the hollow dot (Lavender/Subtext)
    , ppVisible         = xmobarColor "#bac2de" "" . const "\xf0130 "
    -- \xf0130 for hidden workspaces with windows (Surface2)
    , ppHidden          = xmobarColor "#c2b9ec" "" . const "\xf0130 "
    -- Empty workspaces (Surface0)
    , ppHiddenNoWindows = xmobarColor "#45475a" "" . const "\xf0130 "
    , ppLayout          = xmobarColor "#f9e2af" ""
    , ppTitle           = xmobarColor "#cdd6f4" "" . shorten 40
    }

myConfig = def
    { terminal           = myTerminal
    , modMask            = myModMask		-- Super/Windows key as the modifier
    , borderWidth        = myBorderWidth	-- Defines window borders

    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    
    , layoutHook         = myLayouts
    -- NEW: Tell Xmonad to manage the dock window space
    , manageHook         = (className =? "feh" --> doCenterFloat) <+> (className =? "nmtui-floating" --> doRectFloat (W.RationalRect 0.02 0.50 0.60 0.48)) <+> manageDocks <+> manageHook def
    }
    `additionalKeysP` myKeys
