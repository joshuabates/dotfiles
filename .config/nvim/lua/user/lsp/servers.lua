local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

-- local servers = {
--   "cssls",
--   "html",
--   "solargraph",
--   "tsserver",
--   "jsonls",
--   "yamlls",
-- }

lsp_installer.setup()

local _, lspconfig = pcall(require, "lspconfig")
-- if not lspconfig_status_ok then
--   return
-- end

local opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
}

lspconfig['cssls'].setup(opts)
lspconfig['html'].setup(opts)
lspconfig['solargraph'].setup(opts)

require("typescript").setup({ server = opts })
