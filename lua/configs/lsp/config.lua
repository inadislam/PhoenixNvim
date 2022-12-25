local lspconfig_imported, lspconfig = pcall(require, "lspconfig")
if not lspconfig_imported then
	return
end

local imported_mason, mason = pcall(require, "mason")
if not imported_mason then
	return
end

local lsp = vim.lsp
local api = vim.api
local handlers = lsp.handlers

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		api.nvim_buf_set_option(bufnr, ...)
	end

	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false
	--------------------------


	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local options = { noremap = true, silent = true }

	buf_set_keymap("n", "<Space>e", "<cmd>lua vim.diagnostic.open_float()<CR>", options)
	buf_set_keymap("n", "<Space>q", "<cmd>lua vim.diagnostic.set_loclist({})<CR>", options)
	buf_set_keymap("n", "<Space>n", "<cmd>lua vim.diagnostic.goto_next()<CR>", options)
	buf_set_keymap("n", "<Space>b", "<cmd>lua vim.diagnostic.goto_prev()<CR>", options)

	buf_set_keymap("n", "<Space>d", "<Cmd>lua vim.lsp.buf.definition()<CR>", options)
	buf_set_keymap("n", "<Space>D", "<Cmd>lua vim.lsp.buf.declaration()<CR>", options)
	buf_set_keymap("n", "<Space>T", "<cmd>lua vim.lsp.buf.type_definition()<CR>", options)
	buf_set_keymap("n", "<Space>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
	buf_set_keymap("n", "<Space>s", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
	buf_set_keymap("n", "<Space>h", "<Cmd>lua vim.lsp.buf.hover()<CR>", options)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", options)

	buf_set_keymap("n", "<Space>r", "<cmd>Telescope lsp_references<CR>", options)
	buf_set_keymap("n", "<Space>f", "<cmd>lua vim.lsp.buf.format()<CR>", options)

	buf_set_keymap("n", "<Space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)
	buf_set_keymap("x", "<Space>a", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", options)

end

local function setup_lsp_config()
	vim.diagnostic.config({
		float = {
			border = "rounded",
			focusable = true,
			style = "minimal",
			source = "always",
			header = "",
			prefix = "",
		},
	})

	handlers["textDocument/publishDiagnostics"] = lsp.with(lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		signs = true,
		update_in_insert = true,
		virtual_text = {
			true,
			spacing = 6,
		},
	})

	handlers["textDocument/hover"] = lsp.with(handlers.hover, { border = "rounded" })
	handlers["textDocument/signatureHelp"] = lsp.with(handlers.signature_help, { border = "rounded" })

	api.nvim_command([[ sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl= ]])
	api.nvim_command([[ sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl= ]])
	api.nvim_command([[ sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl= ]])
	api.nvim_command([[ sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl= ]])

	api.nvim_command([[ hi DiagnosticUnderlineError cterm=underline gui=underline guisp=#840000 ]])
	api.nvim_command([[ hi DiagnosticUnderlineHint cterm=underline  gui=underline guisp=#07454b ]])
	api.nvim_command([[ hi DiagnosticUnderlineWarn cterm=underline  gui=underline guisp=#2f2905 ]])
	api.nvim_command([[ hi DiagnosticUnderlineInfo cterm=underline  gui=underline guisp=#265478 ]])

end

local function setup_lsp(mason_lspconfig)
	local tbl_deep_extend = vim.tbl_deep_extend
	local capabilities = lsp.protocol.make_client_capabilities()
	local lsp_options = {
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
		capabilities = capabilities,
	}
	local import_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if import_cmp_lsp then
		lsp_options.capabilities = (cmp_lsp).default_capabilities(capabilities)
	end

	lspconfig["dartls"].setup(lsp_options)

	mason_lspconfig.setup_handlers({

		function(server_name)
			require("lspconfig")[server_name].setup(lsp_options)
		end,

		["clangd"] = function()
			lspconfig.clangd.setup(
				tbl_deep_extend("force", lsp_options, { capabilities = { offsetEncoding = { "utf-16" } } })
			)
		end,
		["html"] = function()
			lspconfig.html.setup(tbl_deep_extend("force", lsp_options, { filetypes = { "html", "htmldjango" } }))
		end,
		["cssls"] = function()
			lspconfig.cssls.setup(tbl_deep_extend("force", lsp_options, {
				capabilities = {
					textDocument = { completion = { completionItem = { snippetSupport = true } } },
				},
			}))
		end,
		["sumneko_lua"] = function()
			lspconfig.sumneko_lua.setup(tbl_deep_extend("force", lsp_options, {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "use", "require" },
						},
						workspace = {
							library = api.nvim_get_runtime_file("", true),
						},
						telemetry = { enable = false },
					},
				},
			}))
		end,
	})
end

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

local import_mlspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")

local import_mconfig, mconfig = pcall(require, "configs.lsp.mason")

mason.setup(mconfig.setup)
setup_lsp_config()
setup_lsp(mason_lspconfig)