local M = {}

function M.on_attach()
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("my.lsp", {}),
		callback = function(args)
			local buffer = args.buf
			local diagnostics_enabled = true
			local completion_enabled = true -- start with completion off
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
      local has_navic, navic = pcall(require, "nvim-navic")

			if client:supports_method("textDocument/completion") then
				local chars = {}
				for i = 32, 126 do
					table.insert(chars, string.char(i))
				end
				client.server_capabilities.completionProvider.triggerCharacters = chars
				vim.lsp.completion.enable(completion_enabled, client.id, buffer, { autotrigger = true })
			end
      if has_navic and client.server_capabilities.documentSymbolProvider then
        navic.attach(client, buffer)
      end

			-- toggle options
			function Toggle_completion()
				completion_enabled = not completion_enabled
				vim.lsp.completion.enable(completion_enabled, client.id, buffer, { autotrigger = true })
				print("Completion " .. (completion_enabled and "on" or "off"))
			end

			function Toggle_diagnostics()
				diagnostics_enabled = not diagnostics_enabled
				vim.diagnostic.enable(diagnostics_enabled)
				print("Diagnostics " .. (diagnostics_enabled and "on" or "off"))
			end

			local function map(lhs, rhs, opts)
				opts = opts or {}
				vim.keymap.set(
					opts.mode or "n",
					lhs,
					type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
					{ silent = true, buffer = buffer, expr = opts.expr, desc = opts.desc }
				)
			end

      --stylua: ignore start
			map("<leader>ld", Toggle_diagnostics, { mode = "n", desc = "Toggle Diagnostics" })
			map("<leader>lc", Toggle_completion, { mode = "n", desc = "Toggle Completion" })
      map("<leader>vd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
      map("<leader>li", "LspInfo", { desc = "Lsp Info" })
      map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
      map("<leader>cf", "ALEFix", { desc = "Format Document", has = "documentFormatting" })
      map("[<CR>", function() vim.diagnostic.jump({count=1, float=true}) end, { desc = "goto previous diagnostic", mode = { "n" } })
      map("]<CR>", function() vim.diagnostic.jump({count=-1, float=true}) end, { desc = "goto next diagnostic", mode = { "n" } })
			--stylua: ignore end
		end,
	})
end

return M
