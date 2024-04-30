local lazypath = vim.fn.stdpath("config") .. "/plugins/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct
vim.g.maplocalleader = " " -- Same for `maplocalleader`

-- https://github.com/yuucu/dotfiles/blob/79adcdebf7bc36b7cb6e14c2bbcf157ebb12a54f/config/nvim/lua/lazyvim.lua#L18-L20

require("lazy").setup({
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	"mileszs/ack.vim",
	{ "vifm/vifm.vim", cmd = "Vifm", "DiffVifm" },
	"editorconfig/editorconfig-vim",
	{
		"christoomey/vim-tmux-navigator",
		event = "VimEnter",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		config = function()
			vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { noremap = true, silent = true })
			vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<cr>", { noremap = true, silent = true })
			vim.keymap.set("n", "<c-\\>", ":TmuxNavigatePrevious<cr>", { noremap = true, silent = true })
		end,
	},
	{ "thinca/vim-qfreplace", cmd = "Qfreplace" },
	{
		"j-hui/fidget.nvim",
		config = function()
			require("fidget").setup({})
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "ModeChanged",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"tpope/vim-fugitive",
		cmd = "Git",
		"Gcd",
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("telescope").setup({
				defaults = {
					layout_strategy = "vertical",
					-- theme="dropdown",
					borderchars = { "", "", "", "", "", "", "", "" },
					-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
					layout_config = { vertical = { width = 0.999, height = 0.999, opacity = 0.99 } },
					mappings = {
						i = {
							-- https://medium.com/@shaikzahid0713/telescope-333594836896
							["<esc>"] = require("telescope.actions").close,
							["<C-u>"] = false,
							["<C-j>"] = require("telescope.actions").move_selection_next,
							["<C-k>"] = require("telescope.actions").move_selection_previous,
						},
					},
					winblend = 20,
				},
			})
			local builtin = require("telescope.builtin")

			vim.keymap.set("n", "<leader>m", builtin.oldfiles)
			vim.keymap.set("n", "<leader>p", builtin.git_files)
			vim.keymap.set("n", "<leader>y", builtin.registers)
			vim.keymap.set("n", "<leader>h", builtin.help_tags)
			vim.keymap.set("n", "<leader>ca", builtin.lsp_references)
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signcolumn = true,
				numhl = true,
				linehl = false,
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "<C-g>n", function()
						if vim.wo.diff then
							return "<C-g>n"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "<C-g>p", function()
						if vim.wo.diff then
							return "<C-g>p"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true })

					-- Actions
					map("n", "<C-g>u", gs.reset_hunk)
					map("n", "<C-g>b", function()
						gs.blame_line({ full = true })
					end)
					map("n", "<C-g>d", gs.preview_hunk)
				end,
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")

			configs.setup({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"java",
					"pug",
					"sql",
					"json",
					"yaml",
					"css",
					"scss",
					"typescript",
					"javascript",
					"html",
				},
				sync_install = false,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Adds LSP completion capabilities
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					-- ["<CR>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
				experimental = {
					ghost_text = true,
				},
			})
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources(
					{ { name = "path" } },
					{ { name = "buffer" } },
					{ {
						name = "cmdline",
						option = { ignore_cmds = { "Man", "!" } },
					} }
				),
			})
		end,
	},
	{
		"nvim-java/nvim-java",
		dependencies = {
			"nvim-java/lua-async-await",
			"nvim-java/nvim-java-core",
			"nvim-java/nvim-java-test",
			"nvim-java/nvim-java-dap",
			"MunifTanjim/nui.nvim",
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-dap",
			{
				"williamboman/mason.nvim",
				opts = {
					registries = {
						"github:nvim-java/mason-registry",
						"github:mason-org/mason-registry",
					},
				},
			},
		},
		opts = {
			root_markers = {
				".vscode",
				-- "settings.gradle",
				-- "pom.xml",
				-- "build.gradle",
				-- "mvnw",
				-- "gradlew",
				-- "build.gradle",
				".git",
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "html", "cssls", "tsserver", "marksman", "yamlls", "vimls", "eslint" },
			})
			require("mason-lspconfig").setup_handlers({
				function(server)
					local opt = {
						-- Function executed when the LSP server startup
						-- on_attach = function(client, bufnr)
						--   local opts = { noremap=true, silent=true }
						--   vim.cmd 'autocmd BufWritePre * lua vim.lsp.buf.format { async = false }'
						-- end,
						capabilities = require("cmp_nvim_lsp").default_capabilities(
							vim.lsp.protocol.make_client_capabilities()
						),
					}

					local lspconfig = require("lspconfig")

					if server == "lua_ls" then
						-- https://github.com/neovim/neovim/issues/21686
						lspconfig[server].setup({
							settings = {
								Lua = {
									runtime = { version = "LuaJIT" },
									diagnostics = { globals = { "vim", "require" } },
									workspace = { library = vim.api.nvim_get_runtime_file("", true) },
									telemetry = { enable = false },
								},
							},
						})
					elseif server == "java" then
						require("java").setup()
						lspconfig.java.setup(opt)
					else
						lspconfig[server].setup(opt)
					end
				end,
			})
			require("mason-null-ls").setup({
				ensure_installed = {
					"stylua",
					-- "editorconfig_checker",
					"prettier",
					"shfmt",
					-- "spectral",
					"sqlfluff",
					"sqlfmt",
					"stylelint",
					"yamlfmt",
				},
				automatic_installation = true,
				handlers = {},
			})
			local null_ls = require("null-ls")

			null_ls.setup({
				debug = true,
				diagnostics_format = "#{m} (#{s}: #{c})",
				sources = {
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.editorconfig_checker,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.sqlfmt,
					null_ls.builtins.formatting.yamlfmt,
					null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.diagnostics.spectral,
					null_ls.builtins.diagnostics.stylelint,
					null_ls.builtins.diagnostics.sqlfluff,
				},
			})

			vim.lsp.handlers["textDocument/publishDiagnostics"] =
				vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
					update_in_insert = false,
					virtual_text = {
						format = function(diagnostic)
							return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
						end,
					},
				})

			vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
			vim.keymap.set("n", "<Leader>f", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")
			vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
			vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
			vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
			vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
			vim.keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
			vim.keymap.set("n", "gn", "<cmd>lua vim.lsp.buf.rename()<CR>")
			vim.keymap.set("n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
			vim.keymap.set("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>")
			vim.keymap.set("n", "cj", "<cmd>lua vim.diagnostic.goto_next()<CR>")
			vim.keymap.set("n", "ck", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
	},
	{
		"nvim-tree/nvim-tree.lua",
		cmd = { "NvimTreeOpen", "NvimTreeToggle" },
		dependencies = {
			-- "nvim-tree/nvim-web-devicons",
		},
		config = function()
			local keymap = vim.api.nvim_set_keymap
			local function my_on_attach(bufnr)
				local api = require("nvim-tree.api")

				local function opts(desc)
					return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
				end

				-- default mappings
				api.config.mappings.default_on_attach(bufnr)

				-- custom mappings
				vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
				vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
				vim.keymap.set("n", "d", api.fs.trash, opts("Help"))
			end
			local opt = { noremap = true, silent = true }
			keymap("n", "<Leader>g", ":Gcd <bar> NvimTreeToggle<Cr>", opt)
			keymap("n", "<Leader>e", ":Gcd <bar> NvimTreeOpen <bar> NvimTreeFindFile<Cr>", opt)
			keymap("n", "<Leader>c", ":Gcd <bar> NvimTreeCollapseKeepBuffers<Cr>", opt)
			require("nvim-tree").setup({
				sort_by = "extension",
				update_focused_file = {
					enable = true,
					update_cwd = false,
					update_root = {
						enable = true,
					},
				},
				view = {
					width = "24%",
					side = "left",
					signcolumn = "no",
				},
				hijack_netrw = false,
				respect_buf_cwd = false,
				prefer_startup_root = true,
				sync_root_with_cwd = true,
				root_dirs = { ".git", ".vscode", ".vim", "package.json" },
				renderer = {
					highlight_git = true,
					highlight_opened_files = "name",
					icons = {
						glyphs = {
							default = "",
							symlink = "s",
							bookmark = "b",
							modified = "●",
							folder = {
								arrow_closed = "=",
								arrow_open = "-",
								default = "",
								open = "",
								empty = "e",
								empty_open = "e",
								symlink = "s",
								symlink_open = "s",
							},
							git = {
								unstaged = "!",
								renamed = "»",
								untracked = "?",
								deleted = "x",
								staged = "+",
								unmerged = "m",
								ignored = "◌",
							},
						},
					},
				},

				git = {
					enable = true,
					ignore = false,
				},

				actions = {
					expand_all = {
						max_folder_discovery = 100,
						exclude = { ".git", "target", "build" },
					},
					open_file = {
						window_picker = {
							chars = "HLJK1234567890",
						},
					},
				},
				trash = {
					cmd = "trash",
				},
				on_attach = my_on_attach,
			})
			vim.g.nvim_tree_bindings = {
				{ key = "d", cb = ":lua NvimTreeTrash()<CR>" },
			}
		end,
	},
})
