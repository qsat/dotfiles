local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- 新しいタブを一番右に作る
keymap("n", "gN", ":tabnew<Return>", opts)

-- move tab
keymap("n", "gh", "gT", opts)
keymap("n", "gl", "gt", opts)

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

--分割版gf
keymap("n", "gs", ":vertical wincmd f<CR>", opts)
keymap("n", "gn", "<C-w>gf", opts)
keymap("n", "<C-h>", "<C-w>W", opts)
keymap("n", "<C-l>", "<C-w>w", opts)
keymap("n", "<Leader>qp", ":cprevious<CR>", opts)
keymap("n", "<Leader>qn", ":cnext<CR>", opts)
keymap("n", "<Leader>lp", ":lp<CR>", opts)
keymap("n", "<Leader>ln", ":lne<CR>", opts)
keymap("n", "<Leader>z", "<C-w>T<CR>", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "0", "g0", opts)
