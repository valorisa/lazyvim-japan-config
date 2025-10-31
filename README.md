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
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
```

### `lua/config/keymaps.lua`

Raccourcis clavier inspirés Takuya et accents français.

```lua
keymap("i", "<C-e>", insert_accent("é"), { desc = "é" })
keymap("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next tab" })
keymap("n", ";f", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
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
  { "folke/noice.nvim", event = "VeryLazy" },
  { "b0o/incline.nvim", event = "BufReadPre", priority = 1200 },
  { "nvimdev/dashboard-nvim", event = "VimEnter" },
  { "akinsho/bufferline.nvim", event = "VeryLazy" },
}
```

### `lua/plugins/editor.lua`

Recherche ultra rapide (Telescope, File Browser).

```lua
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-telescope/telescope-file-browser.nvim" },
    config = function(_, opts) require('telescope').load_extension('file_browser') end,
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
        "pyright", "lua-language-server", "typescript-language-server",
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        lua_ls = {},
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
