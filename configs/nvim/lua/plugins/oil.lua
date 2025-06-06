return {
	{
		"stevearc/oil.nvim",
		cmd = { "Oil" },
		keys = {
			{
				"<C-p>",
				function()
					require("oil").open()
				end,
				desc = "Oil",
			},
		},
    init = function ()
      local oil_open_folder = function(path) require("oil").open(path) end
      require("config.util").attach_file_browser("oil", oil_open_folder)
    end,
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			local column_toggle = true
			local columns = {
				{"type", highlight = "Typedef"},
				"icon",
				{ "permissions", highlight = "Error" },
				{ "size", highlight = "Special" },
				{ "mtime", highlight = "String" },
			}
			require("oil").setup({
				-- Id is automatically added at the beginning, and name at the end
				-- See :help oil-columns
				columns = columns,
				-- Buffer-local options to use for oil buffers
				buf_options = {
					buflisted = false,
					bufhidden = "hide",
				},
				-- Window-local options to use for oil buffers
				win_options = {
					wrap = false,
					signcolumn = "no",
					cursorcolumn = false,
					foldcolumn = "1",
					spell = false,
					list = false,
					conceallevel = 0,
					concealcursor = "n",
				},
				-- Oil will take over directory buffers (e.g. `vim .` or `:e src/`
				default_file_explorer = true,
				-- Restore window options to previous values when leaving an oil buffer
				restore_win_options = true,
				-- Skip the confirmation popup for simple operations
				skip_confirm_for_simple_edits = true,
				-- Deleted files will be removed with the trash_command (below).
				delete_to_trash = false,
				-- Change this to customize the command used when deleting to trash
				-- trash_command = "trash-put",
				-- Selecting a new/moved/renamed file or directory will prompt you to save changes first
				prompt_save_on_select_new_entry = true,
				-- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
				-- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
				-- Additionally, if it is a string that matches "actions.<name>",
				-- it will use the mapping at require("oil.actions").<name>
				-- Set to `false` to remove a keymap
				-- See :help oil-actions for a list of all available actions
				keymaps = {
					["g?"] = "actions.show_help",
					["<cr>"] = "actions.select",
					["<leader>v"] = "actions.select_vsplit",
					["<leader>x"] = "actions.select_split",
					["<leader>t"] = "actions.select_tab",
					["<C-s>"] = function()
						require("oil").save()
					end,
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["."] = "actions.open_cmdline",
					["Q"] = "actions.close",
					["Y"] = "actions.copy_entry_path",
					["R"] = "actions.refresh",
					["-"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["gd"] = function()
						if column_toggle then
							require("oil").set_columns({})
							column_toggle = false
						else
							require("oil").set_columns(columns)
							column_toggle = true
						end
					end,
					["gs"] = "actions.toggle_hidden",
				},
				-- Set to false to disable all of the above keymaps
				use_default_keymaps = true,
				view_options = {
					-- Show files and directories that start with "."
					show_hidden = false,
					-- This function defines what is considered a "hidden" file
					is_hidden_file = function(name, bufnr)
						return vim.startswith(name, ".")
					end,
					-- This function defines what will never be shown, even when `show_hidden` is set
					is_always_hidden = function(name, bufnr)
						return false
					end,
				},
				-- Configuration for the floating window in oil.open_float
				float = {
					-- Padding around the floating window
					padding = 2,
					max_width = 0,
					max_height = 0,
					border = "rounded",
					win_options = {
						winblend = 10,
					},
				},
				-- Configuration for the actions floating preview window
				preview = {
					-- Width dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					-- min_width and max_width can be a single value or a list of mixed integer/float types.
					-- max_width = {100, 0.8} means "the lesser of 100 columns or 80% of total"
					max_width = 0.9,
					-- min_width = {40, 0.4} means "the greater of 40 columns or 40% of total"
					min_width = { 40, 0.4 },
					-- optionally define an integer/float for the exact width of the preview window
					width = nil,
					-- Height dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
					-- min_height and max_height can be a single value or a list of mixed integer/float types.
					-- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
					max_height = 0.9,
					-- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
					min_height = { 5, 0.1 },
					-- optionally define an integer/float for the exact height of the preview window
					height = nil,
					border = "rounded",
					win_options = {
						winblend = 0,
					},
				},
				-- Configuration for the floating progress window
				progress = {
					max_width = 0.9,
					min_width = { 40, 0.4 },
					width = nil,
					max_height = { 10, 0.9 },
					min_height = { 5, 0.1 },
					height = nil,
					border = "rounded",
					minimized_border = "none",
					win_options = {
						winblend = 0,
					},
				},
			})
		end,
	},
}
