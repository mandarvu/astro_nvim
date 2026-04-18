return {
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  enabled = false,
  opts = {
    virtualtext = {
      auto_trigger_ft = { "rust", "lua", "python", "javascript", "typescript" },
      keymap = {
        accept = "<A-y>",
        accept_line = "<A-a>",
        accept_word = "<A-w>",
        dismiss = "<A-e>",
      },
    },
    -- THE FIX: We use the OpenAI FIM wrapper and point it at Ollama
    provider = "openai_fim_compatible",
    provider_options = {
      openai_fim_compatible = {
        api_key = "TERM", -- Clever hack: Ollama doesn't need a key, but the plugin requires this field. "TERM" grabs your terminal name as a dummy key.
        name = "Ollama",
        end_point = "http://127.0.0.1:11434/v1/completions",
        model = "codegemma",
        optional = {
          max_tokens = 256,
          top_p = 0.9,
        },
      },
    },
  },
}

