local keymap = vim.keymap

keymap.set("n", "x", "\"_x")

keymap.set("n", "ss", vim.cmd.split)
keymap.set("n", "sv", vim.cmd.vsplit)

keymap.set("n", "te", vim.cmd.tabe)
keymap.set("n", "<Tab>", vim.cmd.tabn)
keymap.set("n", "<S-Tab>", vim.cmd.tabp)

keymap.set("n", "<space>e", vim.diagnostic.open_float)
keymap.set("n", "[d", vim.diagnostic.goto_prev)
keymap.set("n", "]d", vim.diagnostic.goto_next)
keymap.set("n", "<space>q", vim.diagnostic.setloclist)
