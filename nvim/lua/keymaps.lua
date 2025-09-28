local keymap = vim.keymap

keymap.set("n", "x", "\"_x")

keymap.set("n", "ss", vim.cmd.split)
keymap.set("n", "sv", vim.cmd.vsplit)

keymap.set("n", "<C-Tab>", vim.cmd.bn)
keymap.set("n", "<C-S-Tab>", vim.cmd.bp)
