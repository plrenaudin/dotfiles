-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.api.nvim_set_keymap("n", "M-j", ":cnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "M-k", ":cprevious<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>go", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)
  local cwd = file ~= "" and vim.fn.fnamemodify(file, ":h") or vim.fn.getcwd()
  require("snacks").picker.git_branches({
    finder = "git_branches",
    layout = "select",
    format = "git_branch",
    cwd = cwd,
    confirm = function(picker, item)
      picker:close()
      if not item then
        return
      end
      local ref = item.branch or item.commit
      if not ref then
        return
      end
      vim.api.nvim_buf_call(bufnr, function()
        require("gitsigns").diffthis(ref)
      end)
    end,
  })
end, { desc = "Diff current file with selected branch" })

vim.keymap.set("n", "<leader>ff", LazyVim.pick("files", { root = false }))
vim.keymap.set("n", "<leader>sg", LazyVim.pick("live_grep", { root = false }))

vim.keymap.set("n", "<leader>R", "<cmd>source $MYVIMRC<CR>", { desc = "Reload config" })
