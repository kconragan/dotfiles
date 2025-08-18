-- This file dynamically loads the correct theme based on the platform.
-- On Linux it assumes an installation of Omarchy, which dynamically sets themes

-- Define the path to the Omarchy theme file
local omarchy_theme_path = os.getenv("HOME") .. "/.config/omarchy/current/theme/neovim.lua"

-- Check if the Omarchy theme file exists by trying to open it
local f = io.open(omarchy_theme_path, "r")

if f then
  -- If the file exists (we are on Linux/Omarchy):
  f:close()
  -- Execute and return the contents of the Omarchy theme file.
  return dofile(omarchy_theme_path)
else
  -- If the file does not exist (we are on macOS):
  -- Specify preferred theme here
  return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    opts = { theme = "dragon" },
    config = function(_, opts)
      require("kanagawa").setup({
        theme = opts.theme,
      })
      vim.cmd("colorscheme kanagawa")
    end,
  }
end
