return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason-lspconfig.nvim',
    'williamboman/mason.nvim',
    'b0o/schemastore.nvim',
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local mason_lspconfig = require('mason-lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local methods = vim.lsp.protocol.Methods

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('UserLspConfig', {}),
      callback = function(ev)
        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf, silent = true }

        -- set keybinds
        -- opts.desc = 'Show LSP references'
        vim.keymap.set('n', 'gR', '<cmd>Telescope lsp_references<CR>', { desc = 'Show LSP references' }) -- show definition, references

        opts.desc = 'Go to declaration'
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- go to declaration

        opts.desc = 'Show LSP definitions'
        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts) -- show lsp definitions

        opts.desc = 'Show LSP implementations'
        -- vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts) -- show lsp implementations

        opts.desc = 'Show LSP type definitions'
        -- vim.keymap.set('n', 'gt', '<cmd>Telescope lsp_type_definitions<CR>', opts) -- show lsp type definitions

        opts.desc = 'See available code actions'
        vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

        opts.desc = 'Smart rename'
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts) -- smart rename

        opts.desc = 'Show buffer diagnostics'
        -- vim.keymap.set('n', '<leader>D', '<cmd>Telescope diagnostics bufnr=0<CR>', opts) -- show  diagnostics for file

        opts.desc = 'Show line diagnostics'
        -- vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, opts) -- show diagnostics for line

        opts.desc = 'Go to previous diagnostic'
        -- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

        opts.desc = 'Go to next diagnostic'
        -- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
        --
        opts.desc = 'Show documentation for what is under cursor'
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

        opts.desc = 'Restart LSP'
        vim.keymap.set('n', '<leader>rs', ':LspRestart<CR>', opts) -- mapping to restart lsp if necessary

        -- global lsp mappings
        -- vim.keymap.set('n', '<leader>ds', vim.diagnostic.setloclist, { desc = 'lsp diagnostic loclist' })
      end,
    })

    -- publishDiagnostics
    vim.lsp.handlers[methods.textDocument_publishDiagnostics] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = {
        prefix = '',
        spacing = 8,
      },
      signs = true,
      update_in_insert = false,
    })

    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Change the Diagnostic symbols in the sign column (gutter)
    -- (not in youtube nvim video)
    local signs = { Error = ' ', Warn = ' ', Hint = '󰠠 ', Info = ' ' }
    for type, icon in pairs(signs) do
      local hl = 'DiagnosticSign' .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    local servers = {
      -- denols = {
      --   autostart = false,
      --   root_dir = function(fname)
      --     local root_files = { 'deno.json', 'deno.jsonc' }
      --     return require('lspconfig.util').root_pattern(root_files)(fname) or vim.fn.getcwd()
      --   end,
      -- },
      bashls = {},
      -- dockerls = {},
      tailwindcss = {
        autostart = false,
      },
      html = {},
      emmet_language_server = {},
      pyright = {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = 'workspace',
              useLibraryCodeForTypes = true,
            },
          },
        },
      },
      intelephense = {
        root_dir = function(fname)
          local root_files = { '.git' } -- change this to root markers for your project (e.g. package.json, .git, etc)
          vim.print(require('lspconfig.util').root_pattern(root_files)(fname))
          return require('lspconfig.util').root_pattern(root_files)(fname) or vim.fn.getcwd()
        end,
        settings = {
        -- stylua: ignore
        stubs = {
          'bcmath', 'bz2', 'Core', 'curl', 'date', 'dom', 'fileinfo', 'filter', 'gd', 'gettext', 'hash', 'iconv', 'imap',
          'intl', 'json', 'libxml', 'mbstring', 'mcrypt', 'mysql',
          'mysqli', 'password', 'pcntl', 'pcre', 'PDO', 'pdo_mysql', 'Phar', 'readline', 'regex', 'session', 'SimpleXML',
          'sockets', 'sodium', 'standard', 'superglobals', 'tokenizer', 'xml', 'xdebug', 'xmlreader',
          'xmlwriter', 'yaml', 'zip', 'zlib', 'genesis-stubs', 'polylang-stubs',
        },
          files = {
            maxSize = 5000000,
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
          redhat = {
            telemetry = {
              enabled = false,
            },
          },
        },
      },
      yamlls = {
        flags = {
          debounce_text_changes = 150,
        },
        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            format = { enable = true },
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
            completion = true,
            hover = true,
          },
        },
      },
      quick_lint_js = {},
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            hint = {
              enable = false,
            },
            diagnostics = {
              globals = { 'vim', 'C' },
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.fn.expand('$VIMRUNTIME/lua'),
                vim.fn.stdpath('config') .. '/lua',
              },
              maxPreload = 2000,
              preloadFileSize = 1000,
            },
            telemetry = { enable = false },
            completion = { callSnippet = 'Insert' },
          },
        },
      },
    }

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        local server = servers[server_name] or {}
        if server.enabled == false then
          return
        end
        server.compabilities = capabilities
        lspconfig[server_name].setup(server)
      end,
    })
  end,
}
