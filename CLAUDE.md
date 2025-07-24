# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a LazyVim-based Neovim configuration using Lua and the lazy.nvim plugin manager. The configuration follows the LazyVim starter template structure with custom modifications.

## Commands

### Development and Maintenance

- **Update plugins**: Open Neovim and run `:Lazy update`
- **Check plugin status**: `:Lazy`
- **Install new LSP servers/tools**: `:Mason` (interactive UI)
- **Format current file**: `<leader>cf` or `:ConformFormat`
- **Check startup time**: `:Lazy profile`
- **Sync plugins after config changes**: `:Lazy sync`
- **Health check**: `:checkhealth` or `:checkhealth lazy`

### Testing Configuration Changes

- **Reload specific module**: `:lua require("plenary.reload").reload_module("module_name")`
- **Source current file**: `:source %`
- **Check LazyVim extras**: `:LazyExtras`
- **Debug plugin loading**: `:Lazy debug`

### Custom Keymaps

- **Buffer management**: `<leader>bd` (delete buffer), `<leader>bD` (delete buffer and window)
- **Quit commands**: `<leader>qq` (quit all), `<leader>qQ` (quit without saving)

## Architecture

### Core Structure

The configuration is organized into two main directories under `lua/`:

1. **`lua/config/`** - Core configuration modules loaded by LazyVim:
   - `lazy.lua` - Plugin manager setup and LazyVim initialization
   - `autocmds.lua` - Custom autocommands (currently minimal)
   - `keymaps.lua` - Custom key mappings for buffers and quit commands
   - `options.lua` - Vim options overrides (disables animations)

2. **`lua/plugins/`** - Plugin specifications and customizations:
   - Each file returns a table of plugin specs
   - LazyVim automatically loads all `.lua` files in this directory
   - Plugin specs can override or extend LazyVim's default configurations
   - `example.lua` - Contains extensive plugin configuration examples

### Plugin Management Flow

1. `init.lua` loads `config.lazy`
2. `config/lazy.lua` bootstraps lazy.nvim and loads LazyVim
3. LazyVim loads its default plugins and configurations
4. Custom plugins from `lua/plugins/` are merged with defaults
5. LazyVim extras (specified in `lazyvim.json`) are loaded

### LazyVim Extras System

Extras are defined in `lazyvim.json` and provide pre-configured setups for:
- Language support (e.g., `lang.typescript`, `lang.python`)
- Editor features (e.g., `editor.mini-move`, `formatting.biome`)
- Utilities (e.g., `util.startuptime`)

To add/remove extras, modify `lazyvim.json` and run `:Lazy sync`.

## Plugin Configuration Examples

### Adding New Plugins

Simple plugin addition:
```lua
return {
  { "echasnovski/mini.animate", version = false }
}
```

Plugin with dependencies and configuration:
```lua
return {
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  }
}
```

### Modifying LazyVim Defaults

Change the colorscheme:
```lua
return {
  { "LazyVim/LazyVim", opts = { colorscheme = "gruvbox" } }
}
```

Override plugin options:
```lua
return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "😄")
    end,
  }
}
```

### Disabling Default Plugins

```lua
return {
  { "folke/flash.nvim", enabled = false },
  { "echasnovski/mini.indentscope", enabled = false }
}
```

### LSP Server Configuration

Default configuration:
```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {}
      }
    }
  }
}
```

Custom setup:
```lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          settings = {
            completions = {
              completeFunctionCalls = true
            }
          }
        }
      },
      setup = {
        tsserver = function(_, opts)
          -- custom setup logic
        end
      }
    }
  }
}
```

### Mason Tool Installation

Ensure development tools are installed:
```lua
return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      })
    end,
  }
}
```

## Key Files

- `lazyvim.json` - Controls which LazyVim extras are enabled
- `lazy-lock.json` - Pin plugin versions for reproducibility
- `stylua.toml` - Lua code formatting rules (2 spaces, 120 column width)
- `lua/plugins/snacks-dashboard.lua` - Custom dashboard configuration with ASCII art
- `lua/plugins/example.lua` - Comprehensive plugin configuration examples
- `lua/plugins/disabled.lua` - Disables noice.nvim floating notifications
- `lua/plugins/neo-tree.lua` - File explorer keybinding customization
- `lua/plugins/tmux-navigator.lua` - Tmux integration for seamless navigation
- `lua/plugins/twig.lua` - Twig template file support
- `lua/plugins/undotree.lua` - Undo history visualization
- `lua/plugins/vim-sleuth.lua` - Automatic indentation detection
- `lua/plugins/yazi.lua` - Yazi file manager integration

## Important Patterns

1. **Extending LazyVim Plugins**: To modify a LazyVim default plugin, create a spec with the same plugin name in `lua/plugins/`
2. **Disabling Plugins**: Return `{ "plugin/name", enabled = false }`
3. **LSP Configuration**: LSP servers are managed through Mason and configured via LazyVim's lang extras
4. **Keymaps**: LazyVim uses `<leader>` (space by default) for most mappings
5. **Options Functions**: Use `opts = function(_, opts)` to extend existing options, or `opts = {}` to replace them
6. **Setup Functions**: Use the `setup` key in lspconfig opts to customize server initialization
7. **LazyVim Extras Import**: Import additional specs using `{ import = "lazyvim.plugins.extras.lang.typescript" }`
8. **Plugin Configuration Merging**: When the same plugin is configured in multiple files, LazyVim merges the configurations

## Current Configuration

### Enabled LazyVim Extras

**Languages**: 
- `lang.typescript` - TypeScript/JavaScript support
- `lang.python` - Python support with pyright
- `lang.php` - PHP support
- `lang.yaml` - YAML support
- `lang.json` - Enhanced JSON support
- `lang.git` - Git integration

**Coding**: 
- `coding.copilot` - GitHub Copilot AI assistance
- `coding.mini-comment` - Better commenting
- `coding.mini-surround` - Surround text objects
- `coding.yanky` - Enhanced clipboard management

**Editor**: 
- `editor.dial` - Increment/decrement values
- `editor.inc-rename` - Incremental renaming
- `editor.mini-move` - Move lines/blocks

**Formatting**: 
- `formatting.biome` - Biome formatter support
- `formatting.prettier` - Prettier formatter

**UI**: 
- `ui.indent-blankline` - Indentation guides
- `ui.mini-hipatterns` - Highlight patterns

**Utilities**: 
- `util.dot` - GraphViz support
- `util.startuptime` - Startup performance analysis

### Custom Modifications

- **Noice.nvim disabled** - No floating command line or notifications
- **Animations disabled** - `vim.g.snacks_animate = false` for better performance
- **Custom dashboard** - ASCII art and quick actions in `snacks-dashboard.lua`
- **Tmux integration** - Seamless navigation between Neovim and tmux panes
- **Undotree** - Visual undo history with `<leader>u`
- **Yazi integration** - Terminal file manager with `<leader>fy`
- **Twig support** - Syntax highlighting for Twig templates
- **Custom buffer keymaps** - `<leader>bd` to delete buffer, `<leader>bD` to delete buffer and window
- **Custom quit keymaps** - `<leader>qq` to quit all, `<leader>qQ` to quit without saving

## Development Guidelines

### Adding New Plugins

1. Create a new file in `lua/plugins/` or add to existing file
2. Return a table with plugin specifications
3. Use lazy loading keys (`cmd`, `event`, `ft`, `keys`) for better performance
4. Follow existing patterns for consistency

### Modifying Existing Behavior

1. Find the plugin in LazyVim's defaults or your custom configs
2. Create a spec with the same plugin name to override
3. Use `opts = function(_, opts)` to extend options
4. Use `enabled = false` to disable completely

### File Organization

- Group related plugins in the same file
- Use descriptive filenames (e.g., `lsp.lua` for LSP configurations)
- Keep example configurations in `example.lua`
- Document complex configurations with comments

### Performance Considerations

- Use lazy loading whenever possible
- Profile startup with `:Lazy profile`
- Disable unused plugins and extras
- Consider using `event = "VeryLazy"` for non-critical plugins

## Troubleshooting

### Common Issues

1. **Plugin not loading**: Check `:Lazy` for errors, ensure correct spec format
2. **LSP not working**: Run `:checkhealth lsp` and `:Mason` to verify installation
3. **Keybinding conflicts**: Use `:map <key>` to check existing mappings
4. **Slow startup**: Run `:Lazy profile` to identify bottlenecks

### Health Checks

- `:checkhealth` - General health check
- `:checkhealth lazy` - Plugin manager health
- `:checkhealth mason` - LSP/tool installer health
- `:checkhealth lsp` - LSP configuration health

### Debugging

- `:Lazy debug` - Debug plugin loading
- `:LspInfo` - Current buffer LSP information
- `:ConformInfo` - Formatter information
- `vim.notify` messages appear in `:messages`