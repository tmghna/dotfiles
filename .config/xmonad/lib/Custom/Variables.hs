module Custom.Variables where

import XMonad
import XMonad.Actions.CopyWindow (copyToAll, killAllOtherCopies)
import qualified XMonad.StackSet as W
import XMonad.Util.XUtils (stringToPixel)

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
myFocusedBorderColor = "#cba6f7"    -- Mauve glow for the active window

myLockedBorderColor :: String
myLockedBorderColor = "#f38ba8"     -- Catppuccin Red for locked window

-- Toggles a window to be sticky across all workspaces
toggleSticky :: X ()
toggleSticky = withFocused $ \w -> do
    ws <- gets windowset
    -- Grab every single window currently open across all workspaces
    let allWindows = concatMap (W.integrate' . W.stack) (W.workspaces ws)
        -- If the window appears more than once, it is currently "locked"
        isLocked   = length (filter (== w) allWindows) > 1
    
    if isLocked
        then do
            killAllOtherCopies -- Unlocks: removes it from all other workspaces
            setFocusBorder w myFocusedBorderColor -- Reset to Mauve
        else do
            windows (W.sink w)  -- Unfloats: forces it to tile (master or slave)
            windows copyToAll   -- Locks: copies it to every workspace
            setFocusBorder w myLockedBorderColor  -- Set to Red

-- Helper function to explicitly change the border color of a specific window
setFocusBorder :: Window -> String -> X ()
setFocusBorder w color = withDisplay $ \d -> do
    c <- io $ stringToPixel d color
    io $ setWindowBorder d w c

-- Watchdog function to keep the border red when returning focus to the sticky window
updateLockedBorder :: X ()
updateLockedBorder = withFocused $ \w -> do
    ws <- gets windowset
    let allWindows = concatMap (W.integrate' . W.stack) (W.workspaces ws)
        isLocked   = length (filter (== w) allWindows) > 1
    if isLocked 
        then setFocusBorder w myLockedBorderColor 
        else setFocusBorder w myFocusedBorderColor
