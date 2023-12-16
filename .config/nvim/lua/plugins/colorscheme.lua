return {
  -- {
  --   "olimorris/onedarkpro.nvim",
  --   lazy = true,
  --   opts = { style = "night" },
  -- },
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
