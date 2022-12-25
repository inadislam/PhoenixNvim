local M = {}

M.setup = {
    automatic_installation = false,

    ui = {
        check_outdated_servers_on_open = true,
        border = 'rounded',
        icons = {
            package_pending = ' ',
            package_installed = ' ',
            package_uninstalled = 'ﮊ',
        },
        keymaps = {
            toggle_server_expand = '<CR>',
            install_server = 'i',
            update_server = 'u',
            check_server_version = 'c',
            update_all_servers = 'ua',
            uninstall_server = 'x',
        },
    },
    log_level = vim.log.levels.INFO,
    max_concurrent_installers = 4,
}

return M