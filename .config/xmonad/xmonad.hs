import XMonad
import XMonad.Hooks.DynamicLog

-- NEW: The essential module for status bars
import XMonad.Hooks.ManageDocks

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
    { -- Reorders the output to Layout, Workspace, Title
      ppOrder           = \(ws:l:t:_) -> [l, ws, t]
      
      -- Sets the divider between sections
    , ppSep             = " <fc=#6c7086>|</fc> "
    
      -- Wraps the currently active workspace in brackets and colors it green
    , ppCurrent         = xmobarColor "#a6e3a1" "" . wrap "[" "]"
    
      -- Wraps hidden workspaces that have open windows in brackets and colors them blue
    , ppHidden          = xmobarColor "#89b4fa" "" . wrap "[" "]"
    
      -- Wraps empty workspaces in brackets and dims them
    , ppHiddenNoWindows = xmobarColor "#45475a" "" . wrap "[" "]"
    
      -- Colors the Layout text (Tall, Mirror Tall, Full)
    , ppLayout          = xmobarColor "#fab387" ""
    
      -- Colors the window title and cuts it off if it gets too long
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
    , manageHook         = manageDocks <+> manageHook def
    }
    `additionalKeysP` myKeys
