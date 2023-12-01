return {
  {
    "ribru17/bamboo.nvim",
    lazy = false,
    priority = 1000,
    config = function ()
      local bamboo = require("bamboo")
      bamboo.setup({
        transparent = true,
        lualine = { transparent = true },
      })
      bamboo.load()

      vim.api.nvim_set_hl(0, "CursorLine", { underline = true })
    end
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "vim", "json" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },

  { "lewis6991/gitsigns.nvim", opts = {} },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { options = { section_separators = "", component_separators = "" } },
  },
}
