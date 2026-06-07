import XMonad
import XMonad.Hooks.DynamicLog
import qualified XMonad.StackSet as W

-- NEW: The essential module for status bars
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers

-- Essential for workspace data
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.UpdatePointer

import XMonad.Util.EZConfig (additionalKeysP)
import Graphics.X11.ExtraTypes.XF86

-- Startup Hooks
import XMonad.Util.SpawnOnce (spawnOnce)

-- Import custom modules
import Custom.Variables
import Custom.Keybindings
import Custom.Layouts
import Custom.Startups (myStartupHook)

-- Counts the number of windows on the current workspace
windowCount :: X (Maybe String)
windowCount = withWindowSet $ \ws -> do
  let currWs = W.workspace . W.current $ ws
  let z = W.stack currWs
  case z of
    Nothing -> return $ Just "(0)"
    Just s -> return $ Just $ "(" ++ show (length $ W.integrate s) ++ ")"

main :: IO ()
-- Wrap myConfig in 'docks' so Xmonad actively listens for Xmobar
main = xmonad =<< statusBar "xmobar" myXmobarPP toggleStrutsKey (ewmh $ docks myConfig)

-- This adds a shortcut (Super + f) to toggle the bar on and off if you want full screen
toggleStrutsKey XConfig { modMask = m } = (m, xK_f)

-- This entirely customizes the %StdinReader% output format
myXmobarPP :: PP
myXmobarPP = xmobarPP
    { ppOrder           = \(ws:l:t:ex) -> [l ++ " " ++ unwords ex, ws, t]
    , ppSep             = "  " 
    -- \xf012f is the Nerd Font hex for the filled dot (Mauve)
    , ppCurrent         = xmobarColor "#cba6f7" "" . const "<fn=2>\xf012f</fn>" 
    -- \xf0130 is the Nerd Font hex for the hollow dot (Lavender/Subtext)
    , ppVisible         = xmobarColor "#bac2de" "" . const "<fn=2>\xf0130</fn>"
    -- \xf0130 for hidden workspaces with windows (Surface2)
    , ppHidden          = xmobarColor "#c2b9ec" "" . const "<fn=2>\xf0130</fn>"
    -- Empty workspaces (Surface0)
    , ppHiddenNoWindows = xmobarColor "#45475a" "" . const "<fn=2>\xf0130</fn>"
    , ppLayout          = xmobarColor "#f9e2af" "" . \x -> case x of
        "Spacing ResizableTall" -> "Tiled "
        "Spacing Mirror ResizableTall" -> "Mirror"
        "Spacing Full"          -> "Filled"
        "Spacing Tall"          -> "Tall"  -- Fallback just in case
        _                       -> x
    , ppTitle           = xmobarColor "#a6e3a1" "" . shorten 40
    , ppExtras          = [fmap (fmap $ xmobarColor "#eba0ac" "") windowCount] -- NEW: Add the window count to the extras list
    }

myManageHook :: ManageHook
myManageHook = composeAll
    [ isDialog                                 --> doCenterFloat
    , className =? "Blueman-manager"           --> doCenterFloat
    , className =? "feh"                       --> doCenterFloat
    , className =? "nmtui-floating"            --> doRectFloat (W.RationalRect 0.02 0.50 0.60 0.48)
    , className =? "Brave-browser" <&&> appName =? "home_tdey_.config_xmonad_xmonad_keybindings.html" --> doCenterFloat
    , className =? "matplotlib"                --> doCenterFloat
    , className =? "Qalculate-gtk"             --> doCenterFloat
    , className =? "Spotify"                   --> doCenterFloat
    ]

myConfig = def
    { terminal           = myTerminal
    , modMask            = myModMask		-- Super/Windows key as the modifier
    , borderWidth        = myBorderWidth	-- Defines window borders

    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    
    , layoutHook         = myLayouts
    -- NEW: Tell Xmonad to manage the dock window space
    , manageHook = myManageHook <+> manageHook def

    -- NEW: Sticky window red border and Instantly teleport the cursor to the center of the focused window
    , logHook = updateLockedBorder >> updatePointer (0.5, 0.5) (0, 0)

    , startupHook = myStartupHook
    }
    `additionalKeysP` myKeys
