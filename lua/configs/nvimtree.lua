local is_ok, tree = pcall(require, 'nvim-tree')
if not is_ok then
    return
end

local c_is_ok, nt_config = pcall(require, 'nvim-tree.config')
if not c_is_ok then
    return
end

tree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {},
    open_on_tab = false,
    hijack_cursor = false,
    updated_cwd = false,
    hijack_directories = {
        enable = true,
        auto_open = true,
    },
    diagonistics = {
        enable = false,
        icons = {
            hint = '',
            info = '',
            warning = '',
            error = '',
        },
    },
    git = {
        enable = false,
    },
    update_focused_file = {
        enable = true,
        update_cwd = false,
        ignore_list = {},
    },
    system_open = {
        cmd = nil,
        args = {},
    },
    filters = {
        dotfiles = false,
        custom = {},
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
    },
    view = {
        hide_root_folder = false,
        side = 'left',
        signcolumn = 'no',
    },
})