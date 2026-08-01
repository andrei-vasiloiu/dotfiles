return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
      { "<leader>fh", "<cmd>FzfLua helptags<CR>", desc = "Help" },
      { "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
      { "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Diagnostics" },
      { "<leader>ls", "<cmd>FzfLua lsp_document_symbols<CR>", desc = "Document symbols" },
      { "<leader>lS", "<cmd>FzfLua lsp_workspace_symbols<CR>", desc = "Workspace symbols" },
      { "<leader>lr", "<cmd>FzfLua lsp_references<CR>", desc = "References" },
      { "<leader>li", "<cmd>FzfLua lsp_implementations<CR>", desc = "Implementations" },
      { "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", desc = "Definitions" },
    },

    opts = {
      { "fzf-native" },
      fzf_colors = true,
      winopts = {
        height = 0.85,
        width = 0.90,
        preview = {
          layout = "flex",
        },
      },
    },
  },
}
