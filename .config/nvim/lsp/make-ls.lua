---@type vim.lsp.Config
return {
  -- Custom LSP, not recognized by mason-lspconfig or nvim-lspconfig at the moment
  cmd = { "make-ls" },
  root_markers = { "Makefile", "makefile", "GNUmakefile" },
  filetypes = { "make" },
}
