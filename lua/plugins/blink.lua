return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    opts.keymap = opts.keymap or {}
    opts.keymap["<Tab>"] = { "fallback" }
    opts.keymap["<S-Tab>"] = { "fallback" }
  end,
}
