local is_ok, null = pcall(require, 'null-ls')
if not is_ok then
	return
end

local ip, packages = pcall(require, 'mason-registry')
if not ip then
	return
end

local installed_packages = packages.get_installed_package_names()

local formatting = null.builtins.formatting

local sources = {}
local load = false

local api = vim.api
local fn = vim.fn


for _, package in pairs(installed_packages) do
	-- Lua
	if package == 'luaformatter' then
		load = true
		sources[#sources + 1] = formatting.lua_format.with({
			command = 'lua-format',
			args = {
				'--indent-width',
				'1',
				'--tab-width',
				'4',
				'--use-tab',
				'--chop-down-table',
				'--extra-sep-at-table-end',
			},
		})
		goto loop_continue
	end
	if package == 'stylua' then
		load = true
		sources[#sources + 1] = formatting.stylua.with({
			command = 'stylua',
			args = {
				'--search-parent-directories',
				'--stdin-filepath',
				'$FILENAME',
				'-',
			},
		})
		goto loop_continue
	end
	-- Python
	if package == 'black' then
		load = true
		sources[#sources + 1] = formatting.black.with({
			command = 'black',
			args = { '--quiet', '--fast', '-' },
		})
		goto loop_continue
	end
	-- Django ('htmldjango')
	if package == 'djlint' then
		load = true
		sources[#sources + 1] = formatting.djlint.with({
			command = 'djlint',
			args = { '--reformat', '-' },
		})
		goto loop_continue
	end
	-- 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue',
	-- 'css', 'scss', 'less', 'html', 'json', 'yaml', 'markdown', 'graphql'
	if package == 'prettier' then
		load = true
		sources[#sources + 1] = formatting.prettier.with({
			command = 'prettier',
			args = { '--stdin-filepath', '$FILENAME' },
		})
		goto loop_continue
	end

	::loop_continue::
end

if fn.executable('gofmt') == 1 then
	load = true
	sources[#sources + 1] = formatting.gofmt.with({})
end

if load then
	null.setup({
		sources = sources,
	})
end

local group = api.nvim_create_augroup('AbstractNulllsAutoGroup', { clear = true })
api.nvim_create_autocmd('FileType', {
	pattern = 'null-ls-info',
	group = group,
	callback = function()
		api.nvim_win_set_config(0, { border = 'rounded' })
	end,
})

vim.api.nvim_command([[autocmd BufWritePre *.go :silent! lua vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })]])

local keymap = vim.api.nvim_set_keymap
keymap('n', '<Space>f', '<ESC>:lua vim.lsp.buf.format()<CR>', { noremap = true, silent = true })