M = {}

M.setup = {
    ui = {
        check_outdated_packages_on_open = true,
        border = 'rounded',
        icons = {
            package_pending = ' ',
            package_installed = ' ',
            package_uninstalled = 'ﮊ',
        },
        keymaps = {
            toggle_package_expand = "<CR>",
            install_package = 'i',
            update_package = 'u',
            check_package_version = 'c',
            update_all_package = 'ua',
            uninstall_package = 'x',
            cancel_installation = "<C-c>",
            apply_language_filter = "<C-f>",
        },
    },
    pip = {
        install_args = {},
    },
    max_concurrent_installers = 10,
    log_level = vim.log.levels.INFO,
    github = {
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
}

return M