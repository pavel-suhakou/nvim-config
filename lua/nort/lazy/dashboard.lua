return {
    "goolord/alpha-nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        alpha.setup(require 'alpha.themes.startify'.config)

        -- local dashboard = require("alpha.themes.startify")
        --
        -- local sampleDashboard = {
        -- 	[[                                                                       ]],
        -- 	[[                                                                       ]],
        -- 	[[                                                                       ]],
        -- 	[[                                                                       ]],
        -- 	[[                                                                     ]],
        -- 	[[       ████ ██████           █████      ██                     ]],
        -- 	[[      ███████████             █████                             ]],
        -- 	[[      █████████ ███████████████████ ███   ███████████   ]],
        -- 	[[     █████████  ███    █████████████ █████ ██████████████   ]],
        -- 	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
        -- 	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
        -- 	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
        -- 	[[                                                                       ]],
        -- 	[[                                                                       ]],
        -- 	[[                                                                       ]],
        -- }
        -- dashboard.section.header.val = sampleDashboard

        -- alpha.setup(dashboard.opts)
    end,
}
