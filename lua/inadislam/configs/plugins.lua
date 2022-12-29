local fn = vim.fn

-- install packer automatically
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    print('Please close and reopen vim after Installing Packer.Installing...')
    vim.cmd[[ packer packer.nvim ]]
    print('Installed.')
end

-- automatically run :PackerCompile wheneve plugins.lua updated
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local is_ok, packer = pcall(require, 'packer')
if not is_ok then
    return
end

return packer.startup({function ()
    use 'wbthomason/packer.nvim' -- Packer
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'folke/tokyonight.nvim' -- theme
    use {'nvim-treesitter/nvim-treesitter', run=':TSUpdate'} -- treesitter for highlighting
    use 'feline-nvim/feline.nvim' -- feline for bottom status line
    use 'kyazdani42/nvim-web-devicons' -- devicons for all documents specific icons
    use {'akinsho/bufferline.nvim', tag = 'v3.*', requires = 'nvim-tree/nvim-web-devicons'}
    use {'nvim-tree/nvim-tree.lua', requires = {'nvim-tree/nvim-web-devicons'}}
    use {
        'goolord/alpha-nvim',
        requires = { 'nvim-tree/nvim-web-devicons' },
        config = require('configs.alpha')
    }
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'p00f/nvim-ts-rainbow'
    use 'nvim-telescope/telescope.nvim'
    use 'williamboman/nvim-lsp-installer'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
    use 'neovim/nvim-lspconfig'
    use 'jose-elias-alvarez/null-ls.nvim'
    use 'windwp/nvim-autopairs'
    use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'saadparwaiz1/cmp_luasnip'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'
	use 'lewis6991/gitsigns.nvim'
    use 'numToStr/Comment.nvim'
    use 'NvChad/nvim-colorizer.lua'
    use({
		'nvim-telescope/telescope-fzf-native.nvim',
		run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
	})
end,
config = {
    display = {
        open_fn = function ()
            return require('packer.util').float({ border = 'single' })
        end
    }
}})