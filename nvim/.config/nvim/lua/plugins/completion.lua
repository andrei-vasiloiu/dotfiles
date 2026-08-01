return {
  {
    "saghen/blink.cmp",
    version = "1.*",

    opts = {
      keymap = {
        preset = "none",

        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
        ["<Tab>"] = { "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
      },

      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
        },
      },

      snippets = {
        preset = "default",
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      signature = {
        enabled = true,
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
  },
}
