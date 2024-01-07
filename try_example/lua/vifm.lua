local keymap = vim.api.nvim_set_keymap
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand 

local fg = vim.api.nvim_create_augroup('vifmgroup', { clear = true })

vim.g.netrw_banner = 0
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1
-- vim.g.netrw_browse_split = 0
-- vim.g.netrw_altv = 1
-- vim.g.netrw_winsize = 25
-- vim.g.vifm_replace_netrw = 1
-- vim.g.vifm_embed_term = 1
-- vim.g.loaded_vifm = 1
vim.cmd [[
augroup netrw
  autocmd!
  autocmd FileType netrw map <buffer> l <Return>
  autocmd FileType netrw map <buffer> h -
  autocmd FileType netrw map <buffer> q :bd<Return>
  autocmd FileType netrw map <buffer> <C-h> <C-w>W
  autocmd FileType netrw map <buffer> <C-l> <C-w>w
  autocmd FileType netrw hi netrwMarkFile cterm=NONE ctermfg=140 ctermbg=234 guifg=234 guibg=234
augroup END
]]
