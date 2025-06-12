return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				-- lsp symbol navigation for lualine
				"SmiteshP/nvim-navic",
				init = function()
					vim.g.navic_silence = true
				end,
				opts = { separator = " ", highlight = true, depth_limit = 5 },
			},
		},
		config = function()
			require("plugins.lsp.on_attach").on_attach()

			local server_configs = vim.fn.stdpath("config") .. "/lua/plugins/lsp/servers"
			local files = vim.fn.globpath(server_configs, "*.lua", false, true)
			local servers = {}

			for _, file in ipairs(files) do
				local server = vim.fn.fnamemodify(file, ":t:r")
				local ok, config = pcall(require, "plugins.lsp.servers." .. server)

				if ok then
					if type(config) == "function" then
						config = config()
					end

					vim.lsp.config[server] = config
					vim.lsp.enable(server)
					table.insert(servers, server)
				else
					vim.notify("Failed to load LSP config for: " .. server, vim.log.levels.WARN)
				end
			end
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
				automatic_enable = true,
			})

			-- diagnostics
			for name, icon in pairs({ Error = "E", Warn = "W", Hint = "H", Info = "I" }) do
				local hl = "DiagnosticSign" .. name
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				severity_sort = true,
				-- virtual_lines = {current_line = true}
			})
		end,
	},

	-- -- formatters and linters
	{
		"dense-analysis/ale",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			vim.g.ale_linters_explicit = 1
			vim.g.ale_linters = {
				python = { "ruff", "mypy" },
				rust = { "analyzer", "cargo" },
				-- javascript = { "ts_ls" },
				css = { "csslint" },
				-- tex = { "texlab" },
			}

			vim.g.ale_python_mypy_options = "--enable-incomplete-feature=Unpack --check-untyped-defs"
			vim.g.ale_python_mypy_ignore_invalid_syntax = 1
			vim.g.ale_python_ruff_format_options = "--line-length 100"
			vim.g.ale_python_black_options = "--line-length 100"

			vim.g.ale_rust_cargo_use_clippy = vim.fn.executable("cargo-clippy")

			vim.g.ale_fix_on_save = 0
			vim.g.ale_c_clangformat_use_local_file = 1

			vim.g.ale_fixers = {
				["*"] = { "remove_trailing_lines", "trim_whitespace" },
				python = { "ruff_format" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				javascript = { "prettier" },
				css = { "prettier" },
				tex = { "latexindent" },
			}
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = function(_)
			require("mason").setup()
			local ensure_installed = {
				"stylua",
				-- "selene",
				"flake8",
				"black",
				"ruff",
				"mypy",
				"rust-analyzer",
			}
			local mr = require("mason-registry")
			for _, tool in ipairs(ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
}
