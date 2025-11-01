# Setup Neovim Moderne — LazyVim & Solarized Osaka pour le Dev et l'étude du japonais 🇯🇵

Ce projet propose une configuration Neovim clé en main pour Windows 11, inspirée du workflow de Takuya Matsuyama, adaptée au développement Python, TypeScript, Lua et à l’apprentissage du japonais.

***

## Prérequis

- **Neovim 0.9+** compilé avec LuaJIT
- **Git** (pour le clonage et la gestion du dépôt)
- ripgrep, fd pour la recherche rapide (optionnel mais recommandé)
- Une police **Nerd Font** pour les icônes

***

## Installation rapide

```bash
git clone https://github.com/tonpseudo/lazyvim-japan-dev.git
cd lazyvim-japan-dev
# Copier le dossier dans C:\Users\<VotreNom>\AppData\Local\nvim
```

***

## Structure du projet

```tree
nvim/
├── init.lua
├── lua/
│   ├── config/
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   ├── lazy.lua
│   └── plugins/
│       ├── colorscheme.lua
│       ├── ui.lua
│       ├── editor.lua
│       ├── lsp.lua
│       └── coding.lua
```

***

## Fichiers de configuration personnalisés

### `lua/config/options.lua`

Options générales et support Unicode.

```lua
-- Options taken from LazyVim and customized for Windows 11

vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"
vim.opt.timeoutlen = 300
vim.opt.conceallevel = 3

-- Unicode support for accents
vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"


```

### `lua/config/keymaps.lua`

Raccourcis clavier inspirés Takuya et accents français.

```lua
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

```

### `lua/plugins/colorscheme.lua`

Thème Solarized Osaka.

```lua
return {
  "craftzdog/solarized-osaka.nvim",
  branch = "osaka",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
  },
}
```

### `lua/plugins/ui.lua`

Plugins UI avancés (Noice, Notify, Incline, Dashboard, Bufferline).

```lua
return {
  -- Noice for better UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.presets.lsp_doc_border = true
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,
  },

  -- nvim-notify with longer timeout
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 10000,
    },
  },

  -- Incline for floating filenames
  {
    "b0o/incline.nvim",
    event = "BufReadPre",
    priority = 1200,
    config = function()
      local colors = require("solarized-osaka.colors").setup()
      require("incline").setup({
        highlight = {
          groups = {
            InclineNormal = { guibg = colors.magenta500, guifg = colors.base04 },
            InclineNormalNC = { guifg = colors.violet500, guibg = colors.base03 },
          },
        },
        window = { margin = { vertical = 0, horizontal = 1 } },
        hide = {
          cursorline = true,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          if vim.bo[props.buf].modified then
            filename = "[+] " .. filename
          end
          local icon, color = require("nvim-web-devicons").get_icon_color(filename)
          return { { icon, guifg = color }, { " " }, { filename } }
        end,
      })
    end,
  },

  -- Bufferline customization
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- Lualine statusline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "solarized_dark",
      },
    },
  },

  -- Dashboard startup screen
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
          _  |  _  __ o  _  _ 
	  \_/(_| | (_) |  | _> (_|

      ]]
      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },

  -- Mini animate
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
}
```

### `lua/plugins/editor.lua`

Recherche ultra rapide (Telescope, File Browser).

```lua
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function(_, opts)
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local fb_actions = require("telescope").extensions.file_browser.actions

      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            ["n"] = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["/"] = function()
                vim.cmd("startinsert")
              end,
              ["<C-u>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_previous(prompt_bufnr)
                end
              end,
              ["<C-d>"] = function(prompt_bufnr)
                for i = 1, 10 do
                  actions.move_selection_next(prompt_bufnr)
                end
              end,
              ["<PageUp>"] = actions.preview_scrolling_up,
              ["<PageDown>"] = actions.preview_scrolling_down,
            },
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension("file_browser")
    end,
  },
}
```

### `lua/plugins/lsp.lua`

LSP Python, Lua, TypeScript avec Mason.

```lua
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "shellcheck",
        "shfmt",
        "black",
        "isort",
        "pyright",
        "typescript-language-server",
        "lua-language-server",
        "prettier",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
        },
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = { enable = false },
            },
          },
        },
        ts_ls = {},
      },
    },
  },
}
```

### `lua/plugins/coding.lua`

Renommage interactif, productivité.

```lua
return {
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },
}
```

***

## Fonctionnalités

- **Thème Solarized Osaka** harmonieux
- **Dashboard ASCII au démarrage**
- **Navigation intuitive** (Bufferline, Incline)
- **Recherche de fichiers et projet** (Telescope)
- **Support des accents français en insertion**
- **Complétion LSP pour Python, Lua, TypeScript**
- **Prise de notes multilingues** (idéal japonais/français)
- **Adapté pour l'étude du japonais** : prise de notes Unicode, snippets, customisation ready

***

## Raccourcis utiles

| Raccourci                | Action                                          |
|--------------------------|-------------------------------------------------|
| `<Space>ff`              | Recherche de fichiers                           |
| `<Space>LU`              | Mise à jour des plugins                         |
| `<Tab>`, `<S-Tab>`       | Navigation entre tabs                           |
| `Ctrl-e`, `Ctrl-a`, ...  | Accents français rapides                        |
| `<leader>o`, `<leader>O` | Nouvelle ligne sans indentation automatique     |

***

## Inspirations et liens

- [Workflow Japonais de Takuya Matsuyama](https://www.devas.life/effective-neovim-setup-for-web-development-towards-2024/)
- [Solarized Osaka Theme](https://github.com/craftzdog/solarized-osaka.nvim)
- [LazyVim](https://github.com/LazyVim/LazyVim)

***

## Personnalisation et extension

Ajoutez vos propres snippets, modules ou outils d'étude du japonais dans le dossier `lua/plugins/`. Pour toute adaptation linguistique ou pédagogique, documentez votre workflow dans le README selon le même schéma.

***



