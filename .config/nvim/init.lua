-- [[ General Settings ]]
-- Set leader key to space
vim.g.mapleader = ' '
-- Set local leader key to space
vim.g.maplocalleader = ' '
-- Enable Nerd Font support
vim.g.have_nerd_font = true
-- Disable netrw banner
vim.g.netrw_banner = 0
-- Disable line wrapping
vim.opt.wrap = false
-- Set the number of spaces a tab character represents
vim.opt.tabstop = 4
-- Set the number of spaces for a soft tab
vim.opt.softtabstop = 4
-- Set the number of spaces used for each indentation level
vim.opt.shiftwidth = 4
-- Use spaces instead of tabs
vim.opt.expandtab = true
-- Enable smart indentation based on the context
vim.opt.smartindent = true
-- Show line numbers
vim.opt.number = true
-- Enable relative line numbers
vim.opt.relativenumber = true
-- Enable mouse mode
vim.opt.mouse = 'a'
-- Don't show the mode in the status line
vim.opt.showmode = false
-- Clipboard synchronization with the system clipboard
vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)
-- Enable break indent for wrapped lines
vim.opt.breakindent = true
-- Save undo history
vim.opt.undofile = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- Decrease update time
vim.opt.updatetime = 250
-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300
-- Preview substitutions live
vim.opt.inccommand = 'split'
-- Highlight cursor line
vim.opt.cursorline = true
-- Keep a minimal number of screen lines above/below the cursor
vim.opt.scrolloff = 10
-- Enable true color support
vim.opt.termguicolors = true

-- [[ Keybindings ]]
-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open diagnostic [Q]uickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, {
	desc = 'Open diagnostic [Q]uickfix list'
})

-- Disable arrow keys in normal mode with custom messages
vim.keymap.set('n', '<left>', '<cmd><CR>')
vim.keymap.set('n', '<right>', '<cmd><CR>')
vim.keymap.set('n', '<up>', '<cmd><CR>')
vim.keymap.set('n', '<down>', '<cmd><CR>')

-- Keybinds for split window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Keybinding to open file explorer
vim.keymap.set("n", "<leader>e", vim.cmd.Ex)

-- [[ Autocommands ]]
-- Highlight text when yanked (copied)
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end
})

-- [[ Plugins ]]
-- Install lazy plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- [[ Fuzzy Finder ]]
	{
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		branch = '0.1.x',
		dependencies = { "nvim-lua/plenary.nvim", 'nvim-telescope/telescope-ui-select.nvim' },
		config = function()
			require('telescope').setup({})
			require('telescope').load_extension('ui-select')

			local builtin = require('telescope.builtin')

			-- Search using live grep
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
			-- Open file search (no preview)
			vim.keymap.set('n', '<leader>ff', function()
				builtin.find_files({
					previewer = false
				})
			end, {})
		end
	},
	-- [[ Colorscheme ]]
	{
		'rebelot/kanagawa.nvim',
		priority = 1000,
		init = function()
			vim.cmd.colorscheme 'kanagawa'
		end,
		config = function()
			require('kanagawa').setup({
				commentStyle = { italic = false },
				keywordStyle = { italic = false },
				background = { dark = "dragon", light = "lotus" }
			})
		end
	},
	-- [[ Status line ]]
	{
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup {
				options = {
					theme = 'auto',
					section_separators = '',
					component_separators = ''
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'branch' },
					lualine_c = { 'filename' },
					lualine_x = {},
					lualine_y = {},
					lualine_z = { 'location' }
				}
			}
		end
	},
	-- [[ Auto-pairs ]]
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		dependencies = { 'hrsh7th/nvim-cmp' },
		config = function()
			require('nvim-autopairs').setup {}
			local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
			local cmp = require 'cmp'
			cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
		end
	},
	-- [[ Treesitter ]]
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				ensure_installed = { "javascript", "html", "typescript", "lua", "rust" },
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true }
			})
		end
	},
	-- [[ LSP Configuration ]]
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim', 'WhoIsSethDaniel/mason-tool-installer.nvim',
			'j-hui/fidget.nvim',
			'hrsh7th/cmp-nvim-lsp' },
		config = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
				callback = function(event)
					local opts = { buffer = event.buf }

					-- Jump to the definition of the word under your cursor.
					vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, opts)

					-- Find references for the word under your cursor.
					vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, opts)

					-- Jump to the implementation of the word under your cursor.
					vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, opts)

					-- Jump to the type of the word under your cursor.
					vim.keymap.set('n', '<leader>D', require('telescope.builtin').lsp_type_definitions, opts)

					-- Fuzzy find all the symbols in your current document.
					vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, opts)

					-- Fuzzy find all the symbols in your current workspace.
					vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, opts)

					-- Rename the variable under your cursor.
					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)

					-- Execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for this to activate.
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

					-- Goto Declaration (not Goto Definition).
					vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, opts)

					-- Add keybinding for formatting code
					vim.keymap.set('n', '<F3>', function()
						vim.lsp.buf.format({ async = true })
					end, opts)
				end
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

			local servers = {
				gopls = {},
				rust_analyzer = {},
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" }
							}
						}
					}
				}
			}

			local ensure_installed = vim.tbl_keys(servers or {})

			require('mason').setup()
			require('fidget').setup({})
			require('mason-tool-installer').setup {
				ensure_installed = ensure_installed
			}
			require('mason-lspconfig').setup {
				handlers = { function(server_name)
					local server = servers[server_name] or {}
					server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
					require('lspconfig')[server_name].setup(server)
				end }
			}
		end
	},
	-- [[ Autocompletion ]]
	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{
				'L3MON4D3/LuaSnip',
				build = (function()
					if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
						return
					end
					return 'make install_jsregexp'
				end)(),

			}, 'saadparwaiz1/cmp_luasnip',

			'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-path' },
		config = function()
			local cmp = require 'cmp'
			local luasnip = require 'luasnip'
			luasnip.config.setup {}

			cmp.setup {
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end
				},
				completion = {
					completeopt = 'menu,menuone,noinsert'
				},

				mapping = cmp.mapping.preset.insert {
					-- Select the [n]ext item
					['<C-n>'] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					['<C-p>'] = cmp.mapping.select_prev_item(),
					-- Scroll the documentation window [b]ack / [f]orward
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					-- Accept ([y]es) the completion.
					['<C-y>'] = cmp.mapping.confirm {
						select = true
					},
					-- Manually trigger a completion from nvim-cmp.
					['<C-Space>'] = cmp.mapping.complete {},
					-- Think of <c-l> as moving to the right of
					-- <c-l> will move you to the right of each of the expansion locations.
					['<C-l>'] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { 'i', 's' }),
					-- <c-h> is similar, except moving you backwards.
					['<C-h>'] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { 'i', 's' })

				},
				sources = { {
					name = 'lazydev',
					-- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
					group_index = 0
				}, {
					name = 'nvim_lsp'
				}, {
					name = 'luasnip'
				}, {
					name = 'path'
				} }
			}
		end
	} })
