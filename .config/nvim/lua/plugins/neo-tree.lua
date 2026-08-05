return {
  {
    -- Browse and navigate project files.
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      -- Provide common utilities used by Neo-tree.
      "nvim-lua/plenary.nvim",
      -- Provide interface components used by Neo-tree.
      "MunifTanjim/nui.nvim",
    },
    -- Load Neo-tree early so it can handle directory arguments.
    lazy = false,
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({
            source = "filesystem",
            toggle = true,
          })
        end,
        desc = "Toggle file tree",
      },
      {
        "<leader>E",
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd("wincmd p")
            return
          end

          require("neo-tree.command").execute({
            source = "filesystem",
            action = "focus",
          })
        end,
        desc = "Toggle file tree focus",
      },
    },

    opts = {
      -- Track Git state without showing Git status icons.
      enable_git_status = true,

      default_component_configs = {
        -- Hide file and directory icons.
        icon = {
          enabled = false,
        },

        -- Display simple indentation guides.
        indent = {
          indent_marker = "│",
          last_indent_marker = "│",
        },

        -- Hide file metadata.
        file_size = {
          enabled = false,
        },
        type = {
          enabled = false,
        },
        last_modified = {
          enabled = false,
        },
        created = {
          enabled = false,
        },
      },

      window = {
        -- Fit the sidebar to visible entries.
        auto_expand_width = true,

        mappings = {
          -- Expand directories and open files.
          ["l"] = "open",

          -- Collapse directories.
          ["h"] = "close_node",

          -- Keep file search on the global Telescope mapping.
          ["f"] = "none",

          -- Keep sidebar sizing automatic.
          ["e"] = "none",
        },
      },

      filesystem = {
        -- Open Neo-tree when Neovim is started with a directory.
        hijack_netrw_behavior = "open_current",

        -- Keep the current file selected in the tree.
        follow_current_file = {
          enabled = true,
        },

        filtered_items = {
          -- Show dotfiles and Git-ignored files.
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },

      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function()
            -- Hide line numbers and editor gutters.
            vim.opt_local.number = false
            vim.opt_local.relativenumber = false
            vim.opt_local.signcolumn = "no"
            vim.opt_local.foldcolumn = "0"
            vim.opt_local.statuscolumn = ""
          end,
        },
      },
    },
  },
}
