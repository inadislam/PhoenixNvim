local is_ok, ts = pcall(require, 'nvim-treesitter')
if not is_ok then
    return
end

ts.setup({
    ensure_installed = {
        'html',
        'css',
        'javascript',
        'typescript',
        'php',
        'go',
        'lua',
        'python',
    },
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    auto_pairs = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    refactor = {
        highlight_current_scope = { enable = true },
        smart_rename = {
            enable = true,
            keymaps = {
            smart_rename = "grr",
            },
        },
        navigation = {
            enable = true,
            keymaps = {
              goto_definition = "gnd",
              list_definitions = "gnD",
              list_definitions_toc = "gO",
              goto_next_usage = "<A-*>",
              goto_previous_usage = "<A-#>",
            },
        },
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
})