local keymap = vim.api.nvim_set_keymap
local options = {
    noremap = true,
    silent = true,
}
keymap("", "<Space>", "<Nop>", options)
vim.g.mapleader = " "

keymap("n", "<C-s>", ":wa<CR>", options)
keymap("n", "<C-p>", ":Telescope find_files<CR>", options)
keymap("n", "<leader>ft", ":Telescope live_grep<CR>", options)
keymap("n", "<leader>fp", ":Telescope projects<CR>", options)
keymap("n", "<C-b>", ":Telescope buffers<CR>", options)
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", options)
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", options)
keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle.toggle_current_linewise_op()<CR>", options)
keymap(
	"x",
	"<leader>/",
	'<ESC><CMD>lua require("Comment.api").toggle.toggle_current_linewise_op(vim.fn.visualmode())<CR>',
	options
)
keymap("n", "<S-r>", ":LspRestart<CR>", options)