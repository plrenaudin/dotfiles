-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local gitsigns = require("gitsigns")
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>gF", function()
  local current_file_dir = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
  local git_root = vim.fn.systemlist("git -C " .. current_file_dir .. " rev-parse --show-toplevel")[1]

  if vim.v.shell_error == 0 then
    builtin.git_bcommits({
      cwd = git_root, -- Set the working directory to the Git root
    })
  else
    vim.notify("Not in a Git repository!", vim.log.levels.ERROR)
  end
end, { desc = "Git File History" })

vim.keymap.set("n", "<leader>go", function()
  local current_file_dir = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
  local git_root = vim.fn.systemlist("git -C " .. current_file_dir .. " rev-parse --show-toplevel")[1]

  builtin.git_branches({
    cwd = git_root,
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = require("telescope.actions.state").get_selected_entry()
        require("telescope.actions").close(prompt_bufnr)
        if selection then
          gitsigns.diffthis(selection.value)
        end
      end)
      return true
    end,
  })
end, { desc = "Diff current file with selected branch" })
