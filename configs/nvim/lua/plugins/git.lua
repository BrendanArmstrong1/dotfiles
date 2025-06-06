return {
	-- Fugitive
	{
		"tpope/vim-fugitive",
		dependencies = {
			"tpope/vim-rhubarb",
		},
		cmd = { "G", "Gedit", "Gvsplit", "GBrowse" },
		keys = {
			{ "<leader>gp", "<CMD>Git push<CR>" },
			{ "<leader>gr", ":GBrowse!<CR>", mode = "x" },
			{ "<leader>GR", ":GBrowse<CR>", mode = "x" },
			{ "<leader>GL", "<CMD>tab Git log<CR>" },
			{ "<leader>gc", "<CMD>tab Git commit<CR>" },
			{ "<leader>gg", "<CMD>tab Git<CR>" },
			{ "<leader>gb", "<CMD>Git blame<CR>" },
		},
	},

	-- Diffview
	{
		"sindrets/diffview.nvim",
		cmd = "DiffviewOpen",
		keys = {
			{ "<leader>gd", "<cmd>DiffviewFileHistory %<cr>", desc = "open diff of file" },
			{ "<leader>GD", "<cmd>DiffviewOpen<cr>", desc = "open full diff" },
		},
		config = function()
			-- Lua
			local actions = require("diffview.actions")

			require("diffview").setup({
				diff_binaries = false, -- Show diffs for binaries
				enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
				git_cmd = { "git" }, -- The git executable followed by default args.
				hg_cmd = { "hg" }, -- The hg executable followed by default args.
				use_icons = true, -- Requires nvim-web-devicons
				show_help_hints = true, -- Show hints for how to open the help panel
				watch_index = true, -- Update views and index buffers when the git index changes.
				icons = { -- Only applies when use_icons is true.
					folder_closed = "",
					folder_open = "",
				},
				signs = {
					fold_closed = "",
					fold_open = "",
					done = "✓",
				},
				view = {
					-- Configure the layout and behavior of different types of views.
					-- Available layouts:
					--  'diff1_plain'
					--    |'diff2_horizontal'
					--    |'diff2_vertical'
					--    |'diff3_horizontal'
					--    |'diff3_vertical'
					--    |'diff3_mixed'
					--    |'diff4_mixed'
					-- For more info, see ':h diffview-config-view.x.layout'.
					default = {
						-- Config for changed files, and staged files in diff views.
						layout = "diff2_horizontal",
						winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
					},
					merge_tool = {
						-- Config for conflicted files in diff views during a merge or rebase.
						layout = "diff3_horizontal",
						disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
						winbar_info = true, -- See ':h diffview-config-view.x.winbar_info'
					},
					file_history = {
						-- Config for changed files in file history views.
						layout = "diff2_horizontal",
						winbar_info = false, -- See ':h diffview-config-view.x.winbar_info'
					},
				},
				file_panel = {
					listing_style = "tree", -- One of 'list' or 'tree'
					tree_options = { -- Only applies when listing_style is 'tree'
						flatten_dirs = true, -- Flatten dirs that only contain one single dir
						folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
					},
					win_config = { -- See ':h diffview-config-win_config'
						position = "left",
						width = 35,
						win_opts = {},
					},
				},
				file_history_panel = {
					log_options = { -- See ':h diffview-config-log_options'
						git = {
							single_file = {
								diff_merges = "combined",
							},
							multi_file = {
								diff_merges = "first-parent",
							},
						},
						hg = {
							single_file = {},
							multi_file = {},
						},
					},
					win_config = { -- See ':h diffview-config-win_config'
						position = "bottom",
						height = 16,
						win_opts = {},
					},
				},
				commit_log_panel = {
					win_config = { -- See ':h diffview-config-win_config'
						win_opts = {},
					},
				},
				default_args = { -- Default args prepended to the arg-list for the listed commands
					DiffviewOpen = {},
					DiffviewFileHistory = {},
				},
				hooks = {}, -- See ':h diffview-config-hooks'
				keymaps = {
					disable_defaults = false, -- Disable the default keymaps
          --stylua: ignore
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            { "n", "<C-j>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "<C-k>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
            { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel." } },
            { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle through available layouts." } },
            { "n", "[c", actions.prev_conflict, { desc = "In the merge-tool: jump to the previous conflict" } },
            { "n", "]c", actions.next_conflict, { desc = "In the merge-tool: jump to the next conflict" } },
            { "n", "gq", "<CMD>DiffviewClose<cr>", { desc = "close diffview" } },
            { "n", "<leader>ce", actions.conflict_choose("ours"), { desc = "Choose the OURS version of a conflict" } },
            { "n", "<leader>ci", actions.conflict_choose("theirs"), { desc = "Choose the THEIRS version of a conflict" } },
            { "n", "<leader>cu", actions.conflict_choose("base"), { desc = "Choose the BASE version of a conflict" } },
            { "n", "<leader>ca", actions.conflict_choose("all"), { desc = "Choose all the versions of a conflict" } },
            { "n", "dc", actions.conflict_choose("none"), { desc = "Delete the conflict region" } },
            { "n", "<leader>cO", actions.conflict_choose_all("ours"), { desc = "Choose OURS" } },
            { "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose THEIRS" } },
            { "n", "<leader>cB", actions.conflict_choose_all("base"), { desc = "Choose BASE" } },
            { "n", "<leader>cA", actions.conflict_choose_all("all"), { desc = "Choose all the versions" } },
            { "n", "dC", actions.conflict_choose_all("none"), { desc = "Delete the conflict region for the whole file" } },
          },
          --stylua: ignore
          diff1 = {
            -- Mappings in single window diff layouts
            { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
          },
          --stylua: ignore
          diff2 = {
            -- Mappings in 2-way diff layouts
            { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
          },
          --stylua: ignore
          diff3 = {
            -- Mappings in 3-way diff layouts
            { { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS" } },
            { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS" } },
            { "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
          },
          --stylua: ignore
          diff4 = {
            -- Mappings in 4-way diff layouts
            { { "n", "x" }, "1do", actions.diffget("base"), { desc = "Obtain the diff hunk from the BASE" } },
            { { "n", "x" }, "2do", actions.diffget("ours"), { desc = "Obtain the diff hunk from the OURS" } },
            { { "n", "x" }, "3do", actions.diffget("theirs"), { desc = "Obtain the diff hunk from the THEIRS" } },
            { "n", "g?", actions.help({ "view", "diff4" }), { desc = "Open the help panel" } },
          },
          --stylua: ignore
          file_panel = {
            { "n", "j", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
            { "n", "k", actions.prev_entry, { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<up>", actions.prev_entry, { desc = "Bring the cursor to the previous file entry" } },
            { "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
            { "n", "o", actions.select_entry, { desc = "Open the diff for the selected entry" } },
            { "n", "l", actions.select_entry, { desc = "Open the diff for the selected entry" } },
            { "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open the diff for the selected entry" } },
            { "n", "s", actions.toggle_stage_entry, { desc = "Stage / unstage the selected entry" } },
            { "n", "S", actions.stage_all, { desc = "Stage all entries" } },
            { "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
            { "n", "X", actions.restore_entry, { desc = "Restore entry to the state on the left side" } },
            { "n", "L", actions.open_commit_log, { desc = "Open the commit log panel" } },
            { "n", "h", actions.close_fold, { desc = "Collapse fold" } },
            { "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
            { "n", "zO", actions.open_all_folds, { desc = "Expand all folds" } },
            { "n", "zo", actions.open_fold, { desc = "Expand fold" } },
            { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
            { "n", "zm", actions.close_fold, { desc = "Collapse fold" } },
            { "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
            { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
            { "n", "<C-j>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "<C-k>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
            { "n", "gq", "<CMD>DiffviewClose<cr>", { desc = "close diffview" } },
            { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
            { "n", "i", actions.listing_style, { desc = "Toggle between 'list' and 'tree' views" } },
            { "n", "f", actions.toggle_flatten_dirs, { desc = "Flatten empty subdirectories in tree listing style" } },
            { "n", "R", actions.refresh_files, { desc = "Update stats and entries in the file list" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
            { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
            { "n", "[c", actions.prev_conflict, { desc = "Go to the previous conflict" } },
            { "n", "]c", actions.next_conflict, { desc = "Go to the next conflict" } },
            { "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
            { "n", "<leader>cO", actions.conflict_choose_all("ours"), { desc = "Choose OURS" } },
            { "n", "<leader>cT", actions.conflict_choose_all("theirs"), { desc = "Choose THEIRS" } },
            { "n", "<leader>cB", actions.conflict_choose_all("base"), { desc = "Choose BASE" } },
            { "n", "<leader>cA", actions.conflict_choose_all("all"), { desc = "Choose all the versions" } },
            { "n", "dC", actions.conflict_choose_all("none"), { desc = "Delete the conflict region for the whole file" } },
          },
          --stylua: ignore
          file_history_panel = {
            { "n", "g!", actions.options, { desc = "Open the option panel" } },
            { "n", "<C-A-d>", actions.open_in_diffview, { desc = "Open the entry under the cursor in a diffview" } },
            { "n", "y", actions.copy_hash, { desc = "Copy the commit hash of the entry under the cursor" } },
            { "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
            { "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
            { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
            { "n", "j", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
            { "n", "<down>", actions.next_entry, { desc = "Bring the cursor to the next file entry" } },
            { "n", "k", actions.prev_entry, { desc = "Bring the cursor to the previous file entry." } },
            { "n", "<up>", actions.prev_entry, { desc = "Bring the cursor to the previous file entry." } },
            { "n", "<cr>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
            { "n", "o", actions.select_entry, { desc = "Open the diff for the selected entry." } },
            { "n", "<2-LeftMouse>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
            { "n", "<c-b>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
            { "n", "<c-f>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
            { "n", "<C-j>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
            { "n", "<C-k>", actions.select_prev_entry, { desc = "Open the diff for the previous file" } },
            { "n", "gf", actions.goto_file_edit, { desc = "Open the file in the previous tabpage" } },
            { "n", "gq", "<CMD>DiffviewClose<cr>", { desc = "close diffview" } },
            { "n", "<C-w><C-f>", actions.goto_file_split, { desc = "Open the file in a new split" } },
            { "n", "<C-w>gf", actions.goto_file_tab, { desc = "Open the file in a new tabpage" } },
            { "n", "<leader>e", actions.focus_files, { desc = "Bring focus to the file panel" } },
            { "n", "<leader>b", actions.toggle_files, { desc = "Toggle the file panel" } },
            { "n", "g<C-x>", actions.cycle_layout, { desc = "Cycle available layouts" } },
            { "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
          },
          --stylua: ignore
          option_panel = {
            { "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
            { "n", "q", actions.close, { desc = "Close the panel" } },
            { "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
          },
          --stylua: ignore
          help_panel = {
            { "n", "q", actions.close, { desc = "Close help menu" } },
            { "n", "<esc>", actions.close, { desc = "Close help menu" } },
          },
				},
			})
		end,
	},

	-- git signs
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "▎" },
					change = { text = "▎" },
					changedelete = { text = "▎" },
					untracked = { text = "▎" },
				},
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					interval = 1000,
					follow_files = true,
				},
				attach_to_untracked = true,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
				},
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000,
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Navigation
					map("n", "]h", function()
						if vim.wo.diff then
							return "]h"
						end
						vim.schedule(function()
							gs.next_hunk()
							vim.cmd("norm! zz")
						end)
						return "<Ignore>"
					end, { expr = true })

					map("n", "[h", function()
						if vim.wo.diff then
							return "[h"
						end
						vim.schedule(function()
							gs.prev_hunk()
							vim.cmd("norm! zz")
						end)
						return "<Ignore>"
					end, { expr = true })

          -- Actions
          -- stylua: ignore start
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", {silent=true})
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", {silent=true})
          map("n", "<leader>HS", gs.stage_buffer, {silent=true})
          map("n", "<leader>HR", gs.reset_buffer, {silent=true})
          map("n", "<leader>hu", gs.undo_stage_hunk, {silent=true})
          map("n", "<leader>hp", gs.preview_hunk, {silent=true})
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, {silent=true})
          map("n", "<leader>hl", gs.toggle_current_line_blame, {silent=true})
          map("n", "<leader>HL", gs.toggle_linehl, {silent=true})
          map("n", "<leader>hd", gs.diffthis, {silent=true})
          map("n", "<leader>HD", function() gs.diffthis("~") end, {silent=true})
          map("n", "<leader>ht", gs.toggle_deleted, {silent=true})
          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
					-- stylua: ignore end
				end,
			})
		end,
	},
}
