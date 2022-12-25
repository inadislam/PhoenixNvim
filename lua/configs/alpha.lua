local is_ok, alpha = pcall(require, 'alpha')

if not is_ok then
    return
end

local dashboard = require('alpha.themes.dashboard')

math.randomseed(os.time())

local function pick_color()
    local colors = {"String", "Identifier", "Keyword", "Number"}
    return colors[math.random(#colors)]
end

-- function footer_bolte()
--     local total_plugins = #vim.tbl_keys(packer_plugins)
--     local datetime = os.date(' %d-%m-%Y   %H:%M:%S')
--     local v = vim.version()
--     local platform = vim.fn.has "win32" == 1 and "" or ""
--     return string.format(" %d   v%d.%d.%d %s  %s", plugins, v.major, v.minor, v.patch, platform, datetime)
-- end

dashboard.section.header.val = {
    "                :-:.                .::.                 ",
    "              -++:                    :++:               ",
    "            .=*=                       .=*-.             ",
    "       .-. =+*+:                        :+*+- ::         ",
    "      -+: :***+.                        .+***. -+:       ",
    "     :*+. -***+.       :-------:.       .+***: :+*.      ",
    "     =**= :****-        .======--:      -****. =**:      ",
    "     .+**: +***+.       -====-         :****= -**+       ",
    "     :=+**-.+****:     -=====-        -****=.=**+=:      ",
    " ..   =****+-+****+:   :======:     -+****=-+***+=   .   ",
    " .*.   -*+++*++*++*    .+++====:    .*+++++*+++*:   :*   ",
    "  =*-.  :+++++++++*.   :++**++==-   :*+++++++++:  .=*-   ",
    "   =++=--+++++++++++--=+++++**+++--=+++++++++++--=++=    ",
    "    :=+++++++++++++++++++++++*++++++++++++++++++++=.     ",
    "  -:  :==++++++++++++++++++++*+++++++++++++++++=-.  ::   ",
    "   +=: .-=++++++++++++++++++*+++++++++++++++++=:..:+=    ",
    "    =++-:..:-=++++++++++++++++++++++++++++=-:..:-++-     ",
    "     :===+=--=======+++===+++++===========---=+===:      ",
    "       :=================+**+===================:        ",
    "         .:--===========+**-:++============-::.          ",
    "             .:-======+***---:+++=======-:.              ",
    "                   -==****:++.++++==-                    ",
    "                   .=-+**+:**.=**+-=.                    ",
    "                    :::**+.** +**:-:                     ",
    "                     : -** += **- :                      ",
    "                        :*=  -*:                         ",
    "                          =  =                           ",
    "                                                         ",
    "                  P H O E N I X V I M                    ",
}
dashboard.section.header.opts.hl = pick_color()

dashboard.section.buttons.val = {
    dashboard.button('e      ', '  New File  ', ':ene <BAR> startinsert <CR>'),
    dashboard.button('r      ', '  Recent Files  ', ':Telescope oldfiles<CR>'),
    dashboard.button('u      ', '  Update Plugins  ', ':PackerUpdate<CR>'),
    dashboard.button('q      ', '  Quit  ', ':qa<CR>'),
}
dashboard.section.footer.opts.hl = "Constant"
alpha.setup(dashboard.opts)
vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])