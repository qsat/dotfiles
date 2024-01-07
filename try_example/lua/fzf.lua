local key = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
--fzf
key("n", "<Leader>b", ":Buffers<CR>", opts)
key("n", "<Leader>p", ":GFiles<CR>", opts)
key("n", "<Leader>s", ":GFiles?<CR>", opts)
key("n", "<Leader>m", ":History<CR>", opts)
key("n", "<Leader>c", ":BCommits<CR>", opts)

vim.cmd [[
  autocmd! FileType fzf noremap <buffer> <ESC><ESC> :q<CR>
]]
