local is_ok, telescope = pcall(require, 'telescope.nvim')
if not is_ok then
    return
end

telescope.setup({

	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
		},

		initial_mode = 'insert',
		selection_strategy = 'reset',
		sorting_strategy = 'ascending',
		layout_strategy = 'horizontal',
		layout_config = {
			horizontal = {
				mirror = false,
				prompt_position = 'top',
				preview_width = 0.4,
			},
			vertical = { mirror = false },
			width = 0.8,
			height = 0.9,
			preview_cutoff = 80,
		},
		file_ignore_patterns = {
			'__pycache__/',
			'__pycache__/*',

			'build/',
			'gradle/',
			'node_modules/',
			'node_modules/*',
			'smalljre_*/*',
			'target/',
			'vendor/*',
			'venv/',

			'.dart_tool/',
			'.git/',
			'.github/',
			'.gradle/',
			'.idea/',
			'.vscode/',

			'%.sqlite3',
			'%.ipynb',
			'%.lock',
			'%.pdb',
			'%.dll',
			'%.class',
			'%.exe',
			'%.cache',
			'%.pdf',
			'%.dylib',
			'%.jar',
			'%.docx',
			'%.met',
			'%.burp',
			'%.mp4',
			'%.mkv',
			'%.rar',
			'%.zip',
			'%.7z',
			'%.tar',
			'%.bz2',
			'%.epub',
			'%.flac',
			'%.tar.gz',
		},

		file_sorter = require('telescope.sorters').get_fuzzy_file,
		generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
		file_previewer = require('telescope.previewers').vim_buffer_cat.new,
		grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
		qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

		prompt_prefix = '🔎︎ ',
		selection_caret = '➤ ',
		entry_prefix = '  ',
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_devicons = true,
		use_less = true,
		set_env = { ['COLORTERM'] = 'truecolor' },
		path_display = { 'truncate' },

		preview = {
			msg_bg_fillchar = ' ',
			treesitter = false,
		},

		live_grep = {
			preview = {
				treesitter = false,
			},
		},


		buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
	},

	extensions = {

		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},

		['ui-select'] = {
			require('telescope.themes').get_dropdown({
				winblend = 15,
				layout_config = {
					prompt_position = 'top',
					width = 64,
					height = 15,
				},
				border = {},
				previewer = false,
				shorten_path = false,
			}),
		},
	},
})

require('telescope').load_extension('fzf')