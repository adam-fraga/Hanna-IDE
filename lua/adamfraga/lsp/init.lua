local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require("adamfraga.lsp.mason")
require("adamfraga.lsp.handlers").setup()
require("adamfraga.lsp.null-ls")
