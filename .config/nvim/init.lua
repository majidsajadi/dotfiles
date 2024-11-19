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
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic list'})
vim.keymap.set('n', '<left>', '<cmd><CR>', { desc = 'Disable left arrow key' })
vim.keymap.set('n', '<right>', '<cmd><CR>', { desc = 'Disable right arrow key' })
vim.keymap.set('n', '<up>', '<cmd><CR>', { desc = 'Disable up arrow key' })
vim.keymap.set('n', '<down>', '<cmd><CR>', { desc = 'Disable down arrow key' })
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open file explorer' })

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

            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Search text' })
            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({ 
					-- no preview
					previewer = false,
					-- include dotfiles
					hidden = true,
			})
            end, { desc = 'Search file' })
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
				background = { dark = "dragon", light = "lotus" },
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none"
							}
						}
					}
				},
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
					vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, { buffer = event.buf, desc = "Find references" })
					vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, { buffer = event.buf, desc = "Jump to the definition" })
					vim.keymap.set('n', 'gI', require('telescope.builtin').lsp_implementations, { buffer = event.buf, desc = "Jump to the implementation" })

					vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = event.buf, desc = "Rename the variable" })
					vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { buffer = event.buf, desc = "Execute a code action" })
					vim.keymap.set('n', '<leader>fm', function()
						vim.lsp.buf.format({ async = true })
					end, { buffer = event.buf, desc = "Format code" })
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
					['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
					['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
					['<C-y>'] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					['<up>'] = cmp.mapping.select_prev_item(cmp_select),
					['<down>'] = cmp.mapping.select_next_item(cmp_select),
					['<Enter>'] = cmp.mapping.confirm({ select = true }),
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
