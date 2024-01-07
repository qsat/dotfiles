local options = {
	encoding = "utf-8",
	fileencoding = "utf-8",
	title = false,
	backup = false,
	clipboard = "unnamedplus",
	cmdheight = 2,
	completeopt = { "menuone", "noselect" },
	conceallevel = 0,
	hlsearch = true,
	ignorecase = true,
	pumheight = 10,
	showmode = false,
	showtabline = 2,
	smartcase = true,
	autoindent = true,
	smartindent = true,
	swapfile = false,
	termguicolors = true,
	timeoutlen = 300,
	undofile = false,
	updatetime = 300,
	writebackup = false,
	list = false,
	backupskip = { "/tmp/*", "/private/tmp/*" },
	expandtab = true,
  breakindent = true,
	shiftwidth = 2,
	tabstop = 2,
	softtabstop = 2,
	cursorline = false,
	shell = "fish",
	number = false,
	relativenumber = false,
	wrap = false,
	winblend = 0,
	wildoptions = "pum",
	pumblend = 5,
	background = "dark",
	scrolloff = 8,
	sidescrolloff = 8,
	splitbelow = false,
	splitright = false, 
  fileformats= "unix,dos,mac"
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
--vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work  
