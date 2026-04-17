if true then return {} end

local config = {}

config = { "gen740/SmoothCursor.nvim", config = function() require("smoothcursor").setup() end }

return config
