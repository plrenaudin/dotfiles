-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- local gitsigns = require("gitsigns")
vim.api.nvim_set_keymap("n", "M-j", ":cnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "M-k", ":cprevious<CR>", { noremap = true, silent = true })

-- local fzf = require("fzf-lua")

-- vim.keymap.set("n", "<leader>gF", function()
--   fzf.git_bcommits()
-- end, { desc = "Git File History" })

-- vim.keymap.set("n", "<leader>go", function()
--   local current_file_dir = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
--   local git_root = vim.fn.systemlist("git -C " .. current_file_dir .. " rev-parse --show-toplevel")[1]
--   fzf.git_branches({
--     cwd = git_root,
--     actions = {
--       ["default"] = function(selected_branch)
--         -- Extract branch name from the table
--         local branch_name = vim.fn.trim(selected_branch[1]) -- Trim any extra whitespace
--         if not branch_name or branch_name == "" then
--           vim.notify("No branch selected", vim.log.levels.ERROR)
--           return
--         end
--
--         -- Get the Git root directory
--         if not git_root or git_root == "" then
--           vim.notify("Not in a Git repository", vim.log.levels.ERROR)
--           return
--         end
--
--         -- Diff the file using gitsigns
--         gitsigns.diffthis(branch_name)
--       end,
--     },
--   })
-- end, { desc = "Diff current file with selected branch" })
