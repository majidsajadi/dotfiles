return {
  {
    -- Provide language-aware editing using language servers.
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Provide language server completions.
      "hrsh7th/cmp-nvim-lsp",
      -- Display language symbol navigation in a searchable picker.
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      -- Advertise completion support to language servers.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Configure Go language support.
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        settings = {
          gopls = {
            -- Suggest symbols from packages that are not imported yet.
            completeUnimported = true,
            -- Insert placeholders for function arguments during completion.
            usePlaceholders = true,
            analyses = {
              -- Report accidental variable shadowing.
              shadow = true,
              -- Report unused function parameters.
              unusedparams = true,
            },
          },
        },
      })

      -- Configure Rust language support.
      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            -- Report Clippy warnings while editing.
            check = {
              command = "clippy",
            },
          },
        },
      })

      -- Configure Lua support for Neovim configuration files.
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              -- Recognize Neovim's global API object.
              globals = { "vim" },
            },
          },
        },
      })

      -- Start language servers for supported files.
      vim.lsp.enable({
        "gopls",
        "rust_analyzer",
        "lua_ls",
      })
      
      -- Navigate language symbols through Telescope.
      local telescope = require("telescope.builtin")

      vim.keymap.set("n", "<leader>gd", telescope.lsp_definitions, {
        desc = "Go to definition",
      })

      vim.keymap.set("n", "<leader>gi", telescope.lsp_implementations, {
        desc = "Go to implementation",
      })

      vim.keymap.set("n", "<leader>gr", telescope.lsp_references, {
        desc = "Go to references",
      })

      vim.keymap.set("n", "<leader>gt", telescope.lsp_type_definitions, {
        desc = "Go to type definition",
      })

      vim.keymap.set("n", "<leader>gs", telescope.lsp_document_symbols, {
        desc = "Document symbols",
      })

      vim.keymap.set("n", "<leader>gw", telescope.lsp_workspace_symbols, {
        desc = "Workspace symbols",
      })
    end,
  },
}
