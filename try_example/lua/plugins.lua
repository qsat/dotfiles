-- https://github.com/wbthomason/packer.nvim#quickstart
-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

local home = vim.fn.expand('$HOME')
local pack_path = join(home, '.config', 'nvim', 'site')
local package_root = join(pack_path, 'pack')


return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- coloescheme
    use { 'cocopon/iceberg.vim', opt = true }

    use 'tpope/vim-surround'
    use 'tpope/vim-fugitive'
    use 'vifm/vifm.vim'
    use 'editorconfig/editorconfig-vim'
    use 'mattn/emmet-vim'
    use {'junegunn/fzf', run = './install --bin' }
    use 'junegunn/fzf.vim'
    use 'mileszs/ack.vim'
    use 'thinca/vim-qfreplace'
    use { 'digitaltoad/vim-pug', ft = 'pug' }
    use 'christoomey/vim-tmux-navigator'
    -- Load on an autocommand event
    use {'andymass/vim-matchup', event = 'VimEnter'}
    -- Post-install/update hook with neovim command
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- Use dependency and run lua function after load
    use {
      'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },
      config = function() require('gitsigns').setup() end
    }
  end,
  config = {
    package_root = package_root,
  },
)
  --use { "ibhagwan/fzf-lua",
  --  -- optional for icon support
  --  requires = { "nvim-tree/nvim-web-devicons" }
  --}
