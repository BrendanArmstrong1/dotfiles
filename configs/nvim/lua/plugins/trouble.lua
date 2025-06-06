local M = { "folke/trouble.nvim" }

M.cmd = { "Trouble", "TroubleToggle" } -- lazy loads on these commands
M.ft = { "fzf" }
M.branch = "main"

-- stylua: ignore
M.keys = {
	{ "<leader>xx", "<CMD>Trouble diagnostics toggle<cr>", desc = "Toggle Trouble" },
	{ "<leader>xb", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Trouble buffer diagnostics" },
	{ "<leader>xs", "<CMD>Trouble symbols toggle focus=false win.position=right<CR>", desc = "Trouble symbols toggle" },
	{ "<leader>xl", "<CMD>Trouble loclist toggle<CR>", desc = "Trouble loclist" },
	{ "<leader>xq", "<CMD>Trouble qflist toggle<CR>", desc = "Trouble quickfix" },
	{ "gR", "<CMD>Trouble lsp toggle focus=false<CR>", desc = "Trouble lsp_references" },
}

function M.config()
	require("trouble").setup({
		{
			position = "bottom", -- position of the list can be: bottom, top, left, right
			height = 25, -- height of the trouble list when position is top or bottom
			width = 150, -- width of the list when position is left or right
			icons = true, -- use devicons for filenames
			mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
			severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
			fold_open = "v", -- icon used for open folds
			fold_closed = ">", -- icon used for closed folds
			group = true, -- group results by file
			padding = true, -- add an extra new line on top of the list
			cycle_results = true, -- cycle item list when reaching beginning or end of list
			action_keys = { -- key mappings for actions in the trouble list
				-- map to {} to remove a mapping, for example:
				-- close = {},
				close = "Q", -- close the list
				cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
				refresh = "r", -- manually refresh
				jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
				open_split = { "<c-s>" }, -- open buffer in new split
				open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
				open_tab = { "<c-t>" }, -- open buffer in new tab
				jump_close = { "o", "l" }, -- jump to the diagnostic and close the list
				toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
				switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
				toggle_preview = "P", -- toggle auto_preview
				hover = "K", -- opens a small popup with the full multiline message
				preview = "p", -- preview the diagnostic location
				open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
				close_folds = { "zM", "zm" }, -- close all folds
				open_folds = { "zo", "zo" }, -- open all folds
				toggle_fold = { "zA", "za" }, -- toggle fold of current file
				previous = "k", -- previous item
				next = "j", -- next item
				help = "?",
			},
			multiline = true, -- render multi-line messages
			indent_lines = true, -- add an indent guide below the fold icons
			win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
			auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
			auto_fold = false, -- automatically fold a file trouble list at creation
			auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
			include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
			signs = {
				-- icons / text used for a diagnostic
				error = "E",
				warning = "W",
				hint = "H",
				information = "I",
				other = "O",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		},
	})
end

return M
