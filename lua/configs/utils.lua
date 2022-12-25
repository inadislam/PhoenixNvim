local is_ok, autopairs = pcall(require, 'nvim-autopairs')
if not is_ok then
    return
end

autopairs.setup({
    enable_check_bracket_line = true,
	disable_filetype = { 'TelescopePrompt', 'vim' }, --
	enable_afterquote = false,
	enable_moveright = true,

	check_ts = true,
	ts_config = {},
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
if not cmp_autopairs then
    return
end

local import_cmp, cmp = pcall(require, 'cmp')
if not import_cmp then
	return
end
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

local Rule = require('nvim-autopairs.rule')

autopairs.add_rules({
	Rule(' ', ' '):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({ '()', '[]', '{}' }, pair)
	end),
	Rule('( ', ' )')
		:with_pair(function()
			return false
		end)
		:with_move(function(opts)
			return opts.prev_char:match('.%)') ~= nil
		end)
		:use_key(')'),
	Rule('{ ', ' }')
		:with_pair(function()
			return false
		end)
		:with_move(function(opts)
			return opts.prev_char:match('.%}') ~= nil
		end)
		:use_key('}'),
	Rule('[ ', ' ]')
		:with_pair(function()
			return false
		end)
		:with_move(function(opts)
			return opts.prev_char:match('.%]') ~= nil
		end)
		:use_key(']'),
	Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
		:use_regex(true)
		:set_end_pair_length(2),
})