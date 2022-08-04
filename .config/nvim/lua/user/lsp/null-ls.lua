local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
--
local on_attach = function(client, buffnr)
  if (client.resolved_capabilities.document_formatting) then
    vim.cmd [[augroup Format]]
    vim.cmd [[autocmd! * <buffer>]]
    vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    vim.cmd [[augroup END]]
  end

  require("user.lsp.handlers").on_attach(client, buffnr);
end


null_ls.setup {
  debug =true,
  on_attach = on_attach,
  sources = {
    -- code_actions.eslint,
    code_actions.eslint_d,
    diagnostics.eslint_d,
    formatting.eslint_d,
    formatting.fixjson,

    diagnostics.jsonlint,
    diagnostics.rubocop,
    formatting.rubocop,
    --null_ls.builtins.code_actions.gitsigns
    -- formatting.black.with { extra_args = { "--fast" } },
    -- formatting.stylua,
    -- formatting.google_java_format,
    -- diagnostics.flake8,
  },
}
