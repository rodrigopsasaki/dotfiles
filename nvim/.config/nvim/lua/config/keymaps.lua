local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Better movement
map("n", "<leader>w", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)

-- Windows
map("n", "<leader>sv", "<C-w>v", opts)
map("n", "<leader>sh", "<C-w>s", opts)
map("n", "<leader>se", "<C-w>=", opts)
map("n", "<leader>sx", ":close<CR>", opts)

-- Telescope (wired after plugin loads, but safe to predeclare)
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Find files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end,  { desc = "Grep project" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end,    { desc = "Buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end,  { desc = "Help" })
map("n", "<leader>e",  function() require("telescope").extensions.file_browser.file_browser({ path = "%:p:h", respect_gitignore = true, hidden = true, grouped = true }) end, { desc = "File browser" })

