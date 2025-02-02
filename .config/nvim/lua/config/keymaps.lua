-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.api.nvim_set_keymap("n", "M-j", ":cnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "M-k", ":cprevious<CR>", { noremap = true, silent = true })

local snacks = require("snacks")
local gitsigns = require("gitsigns")

local function display_diff(picker, item)
  picker:close()
  if item then
    gitsigns.diffthis(item.branch)
  end
end

-- Custom function to show diff with selected branch using snacks picker
vim.keymap.set("n", "<leader>go", function()
  snacks.picker.git_branches({
    finder = "git_branches",
    layout = "select",
    format = "git_branch",
    current_file = true,
    follow = true,
    confirm = display_diff,
  })
end, { desc = "Diff current file with selected branch" })
