-- ~/.dotfiles/nvim/.config/nvim/lua/plugins/lsp.lua
return {
  -- Mason core: installs/manages LSP binaries
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason registry + native LSP config (no lspconfig)
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup({
        ensure_installed = { "vtsls" },
        automatic_installation = true,
      })

      -- Capabilities: play nice with nvim-cmp if you add it later
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if ok_cmp then
        capabilities = cmp_lsp.default_capabilities(capabilities)
      end

      -- Basic LSP keymaps on attach
      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "gi", vim.lsp.buf.implementation, "Implementations")
        map("n", "K",  vim.lsp.buf.hover, "Hover")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
      end

      -- Resolve the Mason bin for vtsls explicitly
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/vtsls"

      -- Native 0.11 server definition
      vim.lsp.config.vtsls = {
        cmd = { mason_bin },
        filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          typescript = {
            format = { enable = false }, -- let prettier/biome handle formatting later
            preferences = {
              includeInlayParameterNameHints = "all",
              includeInlayVariableTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
            },
          },
          javascript = { format = { enable = false } },
          vtsls = { autoUseWorkspaceTsdk = true },
        },
      }

      -- Start vtsls once installed; if not installed, install then start.
      local mr = require("mason-registry")
      local function start_vtsls_when_ready()
        if vim.fn.executable(mason_bin) == 1 then
          pcall(vim.lsp.enable, "vtsls")
          return true
        end
        return false
      end

      -- If already installed, start now
      if not start_vtsls_when_ready() then
        -- Otherwise, ensure install then start on success
        local ok, pkg = pcall(mr.get_package, "vtsls")
        if ok then
          if not pkg:is_installed() then
            pkg:install()
          end
          pkg:on("install:success", function()
            vim.schedule(function()
              start_vtsls_when_ready()
            end)
          end)
        end
      end

      -- Also try on first TS/JS buffer just in case user opens file before install finishes
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
        callback = function()
          start_vtsls_when_ready()
        end,
      })
    end,
  },
}

