local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("user.lsp.servers")
require("user.lsp.handlers").setup()

require "lsp_signature".setup({
  bind = true,
  handler_opts = {
    border = "single"
  }
})
