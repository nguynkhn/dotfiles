local keymap = vim.keymap

keymap.set("n", "x", "\"_x")

keymap.set("n", "ss", vim.cmd.split)
keymap.set("n", "sv", vim.cmd.vsplit)

keymap.set("n", "te", vim.cmd.tabe)
keymap.set("n", "<Tab>", vim.cmd.tabn)
keymap.set("n", "<S-Tab>", vim.cmd.tabp)
