local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,
  on_attach = function()
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
  end,
  -- on_attach = function(client, bufnr)
  --     if client.supports_method("textDocument/formatting") then
  --         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
  --         vim.api.nvim_create_autocmd("BufWritePre", {
  --             group = augroup,
  --             buffer = bufnr,
  --             callback = function()
  --                 -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
  --                 vim.lsp.buf.formatting_sync()
  --             end,
  --         })
  --     end
  -- end,
  sources = {
    -- code_actions.eslint,
    code_actions.eslint_d,
    diagnostics.eslint_d,
    formatting.eslint_d,

    diagnostics.jsonlint,
    diagnostics.luacheck,
    formatting.rubocop,
    -- formatting.prettier.with {
    --   extra_filetypes = { "toml" },
    --   extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    -- },
    --null_ls.builtins.code_actions.gitsigns
    -- formatting.black.with { extra_args = { "--fast" } },
    -- formatting.stylua,
    -- formatting.google_java_format,
    -- diagnostics.flake8,
  },
}
