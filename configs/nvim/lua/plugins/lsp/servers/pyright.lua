return {
  cmd = { "pyright-langserver", "--stdio" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic", -- "off" | "basic" | "strict"
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        autoImportCompletions = true,
        diagnosticMode = "workspace", -- "openFilesOnly" | "workspace"
        stubPath = vim.fn.stdpath("data") .. "/lazy/python-type-stubs",
        -- Disable specific diagnostics if needed
        diagnosticSeverityOverrides = {
          reportUnusedImport = "information",
          reportUnusedVariable = "information",
        },
      },
    },
  },
  -- on_attach = function(client, bufnr)
  --   -- Disable hover in favor of pylsp if using both
  --   -- client.server_capabilities.hoverProvider = false
  -- end,
}
