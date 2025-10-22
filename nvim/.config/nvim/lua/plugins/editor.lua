return {
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      defaults = {
        mappings = {
          i = { ["<C-j>"] = "move_selection_next", ["<C-k>"] = "move_selection_previous" },
          n = { ["q"] = "close" },
        },
      },
    },
  },
  -- Telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function() require("telescope").load_extension("file_browser") end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "lua","vim","vimdoc","bash",
        "javascript","typescript","tsx","json","yaml","toml",
        "markdown","markdown_inline","query",
      },
    },
    config = function(_, opts) require("nvim-treesitter.configs").setup(opts) end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = { signs = { add = { text = "+" }, change = { text = "~" }, delete = { text = "_" }, topdelete = { text = "‾" }, changedelete = { text = "~" } } },
  },

  -- Which-key for discoverability
  { "folke/which-key.nvim", opts = {} },

  -- Autopairs
  { "windwp/nvim-autopairs", opts = {} },
}

