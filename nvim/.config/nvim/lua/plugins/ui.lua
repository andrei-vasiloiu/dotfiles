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

        overrides = function(colors)
          return {
            NormalFloat = {
              bg = colors.palette.sumiInk1,
            },

            FloatBorder = {
              fg = colors.palette.fujiGray,
              bg = colors.palette.sumiInk1,
            },
          }
        end,
      })

      vim.o.winborder = "rounded"
      vim.cmd.colorscheme("kanagawa-wave")
    end,
  },
}
