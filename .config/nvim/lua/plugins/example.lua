return {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    opts = {
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
        agent = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            name = "Mistral",
            schema = {
              model = {
                default = "mistral-small:latest",
              },
              num_ctx = {
                default = 32000,
              },
              num_predict = {
                default = -1,
              },
            },
          })
        end,
      },
    },
    keys = {
      {
        "<leader>oo",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Ollama Code Companion",
        mode = { "n", "v" },
      },
      {
        "<leader>oc",
        "<cmd>CodeCompanion<cr>",
        desc = "Ollama Inline Companion",
        mode = { "n", "v" },
      },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          show_hidden_count = true,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            -- '.git',
            -- '.DS_Store',
            -- 'thumbs.db',
          },
          never_show = {},
        },
      },
    },
  },
}
