return {
  "oribarilan/lensline.nvim",
  tag = "2.1.0", -- or: branch = 'release/2.x' for latest non-breaking updates
  event = "LspAttach",
  config = function() require("lensline").setup() end,
  opts = {
    -- Profile definitions, first is default
    profiles = {
      {
        name = "basic",
        providers = {
          { name = "usages", enabled = true, include = { "refs" }, breakdown = false },
          { name = "last_author", enabled = true },
        },
        style = { render = "all", placement = "inline" },
      },
      {
        name = "informative",
        providers = {
          { name = "usages", enabled = true, include = { "refs", "defs", "impls" }, breakdown = true },
          { name = "diagnostics", enabled = true, min_level = "HINT" },
          { name = "complexity", enabled = true },
        },
        style = { render = "focused", placement = "inline" },
      },
    },
  },
}
