return {
  {
    -- Search files, text, buffers, and help.
    "nvim-telescope/telescope.nvim",
    -- Load Telescope when its command or key bindings are used.
    cmd = "Telescope",
    dependencies = {
      -- Provide common utilities used by Telescope.
      "nvim-lua/plenary.nvim",
      -- Use Telescope for Neovim selection dialogs.
      "nvim-telescope/telescope-ui-select.nvim",
    },
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            previewer = false,
          })
        end,
        desc = "Find files",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Find text",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Find buffers",
      },
      {
        "<leader>fr",
        function()
          require("telescope.builtin").oldfiles()
        end,
        desc = "Find recent files",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Find help",
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          -- Ignore dependency and Git metadata directories.
          file_ignore_patterns = {
            ".git/",
            "node_modules",
          },
        },
      })

      -- Use Telescope for Neovim selection dialogs.
      require("telescope").load_extension("ui-select")
    end,
  },
}
