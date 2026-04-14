local wezterm = require 'wezterm'
local config = wezterm.config_builder()
local act = wezterm.action

-- 1. Font and Theme
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 11.0
config.color_scheme = 'Catppuccin Mocha'

-- 2. Window Decorations (Removes the bulky title bar)
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

-- 3. Transparency and Padding
config.window_background_opacity = 0.75
config.window_padding = {
  left = 15,
  right = 15,
  top = 15,
  bottom = 15,
}

-- 4. Fix Font Resizing Behavior
config.adjust_window_size_when_changing_font_size = false

-- 5. Stop Wezterms internal clipboard caching
config.enable_wayland = false
config.selection_word_boundary = " \t\n{}[]()\"'`"

-- 5. Shortcut Configurations
config.keys = {
  -- Map Ctrl+Backspace to Ctrl+w (backward kill word)
  {
    key = 'Backspace',
    mods = 'CTRL',
    action = act.SendKey { key = 'w', mods = 'CTRL' },
  },
  -- Forces Wezterm to pull directly from the X11 CLIPBOARD
  { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom 'Clipboard' },
  -- Standard mapping for copying out of Wezterm to the X11 CLIPBOARD
  { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo 'Clipboard' },
  
  -- Optional: If you use Shift+Insert, force it to read the PRIMARY selection
  { key = 'Insert', mods = 'SHIFT', action = act.PasteFrom 'PrimarySelection' },
}

return config
