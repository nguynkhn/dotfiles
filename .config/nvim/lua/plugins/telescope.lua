return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", "Telescope: Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", "Telescope: Live grep" },
  },
}
