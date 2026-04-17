-- In your lazy.nvim plugin configuration (e.g., lua/plugins/codecompanion.lua or init.lua)
if true then return {} end

local config = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim", -- Highly recommended for chat UI
    "MunifTanjim/nui.nvim", -- Often used for UI elements by olimorris' plugins
  },
  -- `opts` is a convenient way to pass configuration directly to the plugin's setup function
  opts = {
    adapters = {
      acp = {
        gemini_cli = function()
          return require("codecompanion.adapters").extend("gemini_cli", {
            defaults = {
              auth_method = "oauth-personal",
            },
          })
        end,
      },
    },
  },
}

return config
