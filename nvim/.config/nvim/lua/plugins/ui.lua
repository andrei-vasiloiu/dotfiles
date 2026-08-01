return {
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = false,
        transparent = false,
        dimInactive = false,
        terminalColors = true,

        commentStyle = {
          italic = false,
        },

        keywordStyle = {
          italic = false,
        },
      })

      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
}
