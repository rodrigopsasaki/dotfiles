local aug = vim.api.nvim_create_augroup
local auc = vim.api.nvim_create_autocmd

-- Highlight on yank
aug("YankHighlight", { clear = true })
auc("TextYankPost", {
  group = "YankHighlight",
  callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 120 }) end,
})

-- Make help open in a vertical split if already in a split
auc("BufWinEnter", {
  pattern = { "*.txt" },
  callback = function()
    if vim.bo.buftype == "help" then vim.cmd.wincmd("L") end
  end,
})

