local wezterm = require 'wezterm'
local config = wezterm.config_builder()

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

return config
