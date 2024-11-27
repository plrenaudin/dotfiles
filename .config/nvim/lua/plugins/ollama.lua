-- return {
--   "nomnivore/ollama.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--   },
--
--   -- All the user commands added by the plugin
--   cmd = { "Ollama", "OllamaModel", "OllamaServe", "OllamaServeStop" },
--
--   keys = {
--     -- Sample keybind for prompt menu. Note that the <c-u> is important for selections to work properly.
--     {
--       "<leader>oo",
--       ":<c-u>lua require('ollama').prompt()<cr>",
--       desc = "ollama prompt",
--       mode = { "n", "v" },
--     },
--
--     -- Sample keybind for direct prompting. Note that the <c-u> is important for selections to work properly.
--     {
--       "<leader>oG",
--       ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>",
--       desc = "ollama Generate Code",
--       mode = { "n", "v" },
--     },
--   },
--
--   ---@type Ollama.Config
--   opts = {
--     -- your configuration overrides
--     model = "qwen2.5-coder:14b",
--   },
-- }
--
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
    "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
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
          name = "qwen2.5-coder:14b",
          schema = {
            model = {
              default = "qwen2.5-coder:14b",
            },
            num_ctx = {
              default = 16384,
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
}
