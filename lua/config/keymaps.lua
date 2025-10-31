-- Keymaps customized for workflow inspired by Takuya Matsuyama

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader key (already Space in LazyVim)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Accents français
local function insert_accent(char)
  return function()
    vim.api.nvim_put({ char }, "c", true, true)
  end
end

keymap("i", "<C-e>", insert_accent("é"), { desc = "é" })
keymap("i", "<C-E>", insert_accent("È"), { desc = "È" })
keymap("i", "<C-a>", insert_accent("à"), { desc = "à" })
keymap("i", "<C-c>", insert_accent("ç"), { desc = "ç" })
keymap("i", "<C-^>", insert_accent("ê"), { desc = "ê" })
keymap("i", "<C-'>", insert_accent("ë"), { desc = "ë" })
keymap("i", "<C-u>", insert_accent("ù"), { desc = "ù" })
keymap("i", "<C-i>", insert_accent("î"), { desc = "î" })
keymap("i", "<C-o>", insert_accent("ô"), { desc = "ô" })

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Window management
keymap("n", "ss", ":split<Return>", opts)
keymap("n", "sv", ":vsplit<Return>", opts)
keymap("n", "sh", "<C-w>h", opts)
keymap("n", "sk", "<C-w>k", opts)
keymap("n", "sj", "<C-w>j", opts)
keymap("n", "sl", "<C-w>l", opts)

-- Tab navigation (matches LazyVim defaults)
keymap("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next tab" })
keymap("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev tab" })

-- Telescope shortcuts (inspired by Takuya)
keymap("n", ";f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", ";r", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap("n", "\\\\", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
keymap("n", ";t", "<cmd>Telescope help_tags<cr>", { desc = "Help Tags" })
keymap("n", ";;", "<cmd>Telescope resume<cr>", { desc = "Resume" })
keymap("n", ";e", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
keymap("n", ";s", "<cmd>Telescope treesitter<cr>", { desc = "Symbols" })
keymap("n", "sf", "<cmd>Telescope file_browser<cr>", { desc = "File Browser" })

-- Disable continuations (Takuya style)
keymap("n", "<leader>o", "o<Esc>^Da", opts)
keymap("n", "<leader>O", "O<Esc>^Da", opts)

-- New tab
keymap("n", "te", ":tabedit<Space>", opts)
