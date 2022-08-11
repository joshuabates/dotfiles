local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
local null_ls_status_ok, null_ls = pcall(require, "null-ls")

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

local solargraph_opts = {
  on_attach = require("user.lsp.handlers").on_attach,
  capabilities = require("user.lsp.handlers").capabilities,
  cmd = { 'bundle', 'exec', 'solargraph', 'stdio' },
}

lspconfig['cssls'].setup(opts)
lspconfig['html'].setup(opts)
lspconfig['solargraph'].setup(opts)

require("typescript").setup({
  debug = true,
  server = opts
})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup {
  debug = true,
  on_attach = on_attach,
  sources = {
    code_actions.eslint_d,
    diagnostics.eslint_d,
    formatting.eslint_d,
    formatting.fixjson,

    diagnostics.jsonlint,
    diagnostics.rubocop,
    -- formatting.rubocop,

    --null_ls.builtins.code_actions.gitsigns
    -- formatting.black.with { extra_args = { "--fast" } },
    -- formatting.stylua,
    -- formatting.google_java_format,
    -- diagnostics.flake8,
  },
}
