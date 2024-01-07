lua <<EOF
require('lint').linters_by_ft = {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d'},
  javascriptreact = { 'eslint_d'},
  typescriptreact = { 'eslint_d'},
  jsx = { 'eslint_d'},
  tsx = { 'eslint_d'},
  json = { 'eslint_d'},
  sh = { 'shellcheck'},
  sql = { 'sqlfluff'},
  yaml = { 'eslint_d'}
}

-- '--no-warn-ignored',
-- require('lint').linters.esilnt_d.args = {
--   '--format',
--   'json',
--   '--stdin',
--   '--stdin-filename',
--   function()
--     return vim.api.nvim_buf_get_name(0)
--   end,
-- }

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})

EOF
