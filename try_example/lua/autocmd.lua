local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand 

--AutoChangeDirectory
autocmd(
  "BufEnter", {
  pattern = {"*"}, 
  callback = function()
	  vim.api.nvim_exec('lcd '..vim.fn.fnameescape(vim.fn.expand('%:p:h')), false)
  end,
})
