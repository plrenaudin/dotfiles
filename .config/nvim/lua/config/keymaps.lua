-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>gF", function()
  local current_file_dir = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":h")
  local git_root = vim.fn.systemlist("git -C " .. current_file_dir .. " rev-parse --show-toplevel")[1]
  vim.notify(git_root, vim.log.levels.ERROR)

  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_bcommits({
      cwd = git_root, -- Set the working directory to the Git root
    })
  else
    vim.notify("Not in a Git repository!", vim.log.levels.ERROR)
  end
end, { desc = "Git File History" })
