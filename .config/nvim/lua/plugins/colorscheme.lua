return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      -- Load the theme but don't apply it yet
      require("catppuccin").setup({
        transparent_background = true,
        flavour = "mocha",
      })

      -- Apply colorscheme
      vim.cmd("colorscheme catppuccin")

      -- Immediately override with transparent backgrounds
      vim.schedule(function()
        local groups_to_clear = {
          "Normal",
          "NormalNC",
          "NormalSB",
          "NormalFloat",
          "FloatBorder",
          "Pmenu",
          "PmenuSel",
          "PmenuSbar",
          "PmenuThumb",
          "StatusLine",
          "StatusLineNC",
          "TabLine",
          "TabLineSel",
          "TabLineFill",
          "SignColumn",
          "LineNr",
          "CursorLineNr",
          "Folded",
          "FoldColumn",
          "EndOfBuffer",
          "VertSplit",
          "WinSeparator",
        }

        for _, group in ipairs(groups_to_clear) do
          pcall(vim.api.nvim_set_hl, 0, group, { bg = "NONE" })
        end
      end)
    end,
  },
  -- {
  --   "rebelot/kanagawa.nvim",
  --   opts = {
  --     transparent = true,
  --     theme = "wave", -- or "dragon", "lotus"
  --   },
  -- },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   opts = {
  --     options = {
  --       transparent = true,
  --     },
  --   },
  -- },
  -- {
  --   "neanias/everforest-nvim",
  --   opts = {
  --     background = "medium", -- soft, medium, hard
  --     transparent_background_level = 2, -- 0, 1, or 2
  --   },
  -- },
  -- {
  --   "folke/tokyonight.nvim",
  --   opts = {
  --     transparent = true,
  --     style = "night",
  --     styles = {
  --       sidebars = "transparent",
  --       floats = "transparent",
  --     },
  --   },
  -- },
}
