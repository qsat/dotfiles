
lua <<EOF
local on_attach = function(client, bufnr)

  -- LSPが持つフォーマット機能を無効化する
  -- 例えばtsserverはデフォルトでフォーマット機能を提供しますが
  -- 利用したくない場合はコメントアウトを解除してください
  -- client.server_capabilities.documentFormattingProvider = false
  
  -- 下記ではデフォルトのキーバインドを設定しています
  -- ほかのLSPプラグインを使う場合（例：Lspsaga）は必要ないこともあります

  local set = vim.keymap.set
  set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  set("n", "<C-m>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  set("n", "gy", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  set("n", "<Leader>a", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  set("n", "<Leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
  set("n", "<Leader>dp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
  set("n", "<Leader>dn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
end

-- 補完プラグインであるcmp_nvim_lspをLSPと連携させています
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- この一連の記述で、mason.nvimでインストールしたLanguage Serverが自動的に個別にセットアップされ、利用可能になります

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
  function (server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach, --keyバインドなどの設定を登録
      capabilities = capabilities, --cmpを連携
    }
  end,
}

vim.diagnostic.config({
  virtual_text = false,
  signs = false
})
EOF
