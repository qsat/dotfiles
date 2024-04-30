local options = {
	encoding = "utf-8",
	fileencoding = "utf-8",
	shell = "zsh",
	title = false,
	backup = false,
	autochdir = true,
	autoread = true,
	autoindent = true,
	breakindent = true,
	clipboard = "unnamedplus",
	cmdheight = 2,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	hlsearch = true,
	incsearch = true,
	ignorecase = true,
	-- mouse = "a",
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	smartindent = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 300,
	undofile = false,
	updatetime = 300,
	writebackup = false,
	backupskip = { "/tmp/*", "/private/tmp/*" },
	expandtab = true,
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
	cursorline = false,
	number = false,
	relativenumber = false,
	numberwidth = 1,
	signcolumn = "yes",
	wrap = true,
	winblend = 0,
	wildoptions = "pum",
	pumblend = 5,
	background = "dark",
	scrolloff = 8,
	sidescrolloff = 8,
	splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
	splitright = false, -- オのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
	list = true,
	listchars = { tab = "--", trail = "-", nbsp = "+" },
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd([[
  set whichwrap+=<,>,[,],h,l
  set iskeyword+=-
  autocmd QuickFixCmdPost *grep* cwindow
  let g:loaded_netrw = 1
  let g:loaded_netrwPlugin = 1
  let g:netrw_banner = 0
  let g:netrw_browse_split = 0
  let g:netrw_altv = 1
  let g:netrw_winsize = 25
  let g:vifm_replace_netrw = 1
  let g:vifm_embed_term = 1
]])
