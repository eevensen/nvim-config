-- AI-powered code completion and generation
-- with support for Gemini, Claude and more.
return {
  'olimorris/codecompanion.nvim',
  cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionToggle', 'CodeCompanionAdd' },
  keys = {
    -- Primary keymaps
    { '<leader>co', '<cmd>CodeCompanionActions<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion Actions' },

    -- Chat operations
    { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', mode = { 'n', 'v' }, desc = 'CodeCompanion Chat' },
    { '<leader>ca', '<cmd>CodeCompanionChat Add<cr>', mode = 'v', desc = 'Add to CodeCompanion' },
    { '<leader>cC', '<cmd>CodeCompanionChat New<cr>', mode = 'n', desc = 'New CodeCompanion Chat' },
    { '<leader>cp', '<cmd>CodeCompanionChat<cr>', mode = 'n', desc = 'Pick CodeCompanion Chat' },

    -- Inline and actions
    { '<leader>ci', '<cmd>CodeCompanion<cr>', mode = 'n', desc = 'Inline CodeCompanion' },
    { '<leader>cs', '<cmd>CodeCompanionCmd<cr>', mode = { 'n', 'v' }, desc = 'Generate Shell Command' },

    -- Custom prompt keybindings - these will work after lazy loading
    { '<leader>cdh', function() vim.cmd('CodeCompanion /Drupal Hook') end, mode = 'n', desc = 'Drupal Hook' },
    { '<leader>ctw', function() vim.cmd('CodeCompanion /Twig Template') end, mode = 'n', desc = 'Twig Template' },
    { '<leader>cds', function() vim.cmd('CodeCompanion /Drupal Service') end, mode = 'n', desc = 'Drupal Service' },
    { '<leader>cde', function() vim.cmd('CodeCompanion /Drupal Expert Mode') end, mode = 'n', desc = 'Drupal Expert Mode' },
    { '<leader>ce', function() vim.cmd('CodeCompanion /Explain Code') end, mode = 'v', desc = 'Explain Code' },
    { '<leader>cx', function() vim.cmd('CodeCompanion /Fix Code') end, mode = 'v', desc = 'Fix Code' },
    { '<leader>cr', function() vim.cmd('CodeCompanion /Refactor Code') end, mode = 'v', desc = 'Refactor Code' },
    { '<leader>ct', function() vim.cmd('CodeCompanion /Generate Tests') end, mode = 'v', desc = 'Generate Tests' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = {
      anthropic = function()
        return require('codecompanion.adapters').extend('anthropic', {
          env = {
            api_key = vim.env.MY_ANTHROPIC_API_KEY,
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = 'anthropic',
        keymaps = {
          send = {
            modes = { n = '<C-s>', i = '<C-s>' },
          },
          close = {
            modes = { n = '<C-c>', i = '<C-c>' },
          },
          -- Add further custom keymaps here
        },
        -- variables = {
        --   ['my_var'] = {
        --     ---Ensure the file matches the CodeCompanion.Variable class
        --     ---@return string|fun(): nil
        --     callback = '/Users/Oli/Code/my_var.lua',
        --     description = 'Explain what my_var does',
        --     opts = {
        --       contains_code = false,
        --     },
        --   },
        -- },
        slash_commands = {
          ['file'] = {
            -- Location to the slash command in CodeCompanion
            callback = 'strategies.chat.slash_commands.file',
            description = 'Select a file using Telescope',
            opts = {
              provider = 'telescope', -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks"
              contains_code = true,
            },
          },
        },
      },
      inline = {
        adapter = 'anthropic',
        inline = {
          keymaps = {
            accept_change = {
              modes = { n = 'ga' },
              description = 'Accept the suggested change',
            },
            reject_change = {
              modes = { n = 'gr' },
              description = 'Reject the suggested change',
            },
          },
          layout = 'vertical', -- vertical|horizontal|buffer
        },
      },
      cmd = {
        adapter = 'anthropic',
      },
    },
    opts = {
      -- Set debug logging
      log_level = 'DEBUG',
    },
    prompts = {
      ['Drupal Hook'] = {
        strategy = 'chat',
        description = 'Implement a Drupal hook',
        opts = {
          index = 1,
          default_prompt = true,
          mapping = '<leader>cdh',
          user_prompt = false,
        },
        prompts = {
          {
            role = 'user',
            content = function()
              return 'Help me implement a Drupal hook. Ask me which hook I need and provide a modern implementation following Drupal 10.4.7 best practices.'
            end,
          },
        },
      },
      ['Twig Template'] = {
        strategy = 'chat',
        description = 'Create or modify a Twig template',
        opts = {
          index = 2,
          default_prompt = true,
          mapping = '<leader>ctw',
          user_prompt = false,
        },
        prompts = {
          {
            role = 'user',
            content = function()
              return 'Help me create or modify a Twig template for my Radix subtheme. Ensure it follows Radix conventions and uses modern Twig patterns with proper Drupal integration.'
            end,
          },
        },
      },
      ['Drupal Service'] = {
        strategy = 'chat',
        description = 'Create a custom Drupal service',
        opts = {
          index = 3,
          default_prompt = true,
          mapping = '<leader>cds',
          user_prompt = false,
        },
        prompts = {
          {
            role = 'user',
            content = function()
              return 'Help me create a custom Drupal service with dependency injection. Follow Drupal 10.4.7 service container best practices.'
            end,
          },
        },
      },
      ['Drupal Expert Mode'] = {
        strategy = 'chat',
        description = 'Activate Drupal/Radix expert context',
        opts = {
          index = 4,
          default_prompt = true,
          mapping = '<leader>cde',
          user_prompt = false,
        },
        prompts = {
          {
            role = 'system',
            content = [[You are an expert developer with deep knowledge of Drupal 10.4.7 and modern web development practices.
I am working with a Drupal subtheme created with Radix (https://www.drupal.org/project/radix), and you should reference the Radix documentation at https://radix.trydrupal.com/radix when needed.

Key expertise areas:
- Drupal 10.4.7 best practices and modern Drupal development patterns
- Radix theme framework and its component-based architecture
- Twig templating with Drupal-specific functions and filters
- Modern CSS/SCSS with utility classes and CSS Grid/Flexbox
- JavaScript ES6+ and Drupal behaviors
- Drupal's render API and theme hooks
- Performance optimization and caching strategies
- Accessibility (WCAG 2.1 AA compliance)
- Responsive design patterns

Always provide modern, clean, and maintainable code that follows Drupal coding standards and leverages the latest features available in Drupal 10.4.7 and Radix.]],
          },
          {
            role = 'user',
            content = function()
              return 'I need help with Drupal development. I am now in Drupal expert mode with knowledge of Drupal 10.4.7 and Radix theme framework.'
            end,
          },
        },
      },
      ['Explain Code'] = {
        strategy = 'chat',
        description = 'Explain how the selected code works',
        opts = {
          index = 5,
          default_prompt = true,
          mapping = '<leader>ce',
          modes = { 'v' },
          user_prompt = false,
        },
        prompts = {
          {
            role = 'user',
            content = function(context)
              local code = require('codecompanion.api').get_code(context.start_line, context.end_line)
              return 'Please explain how this code works:\n\n```' .. context.filetype .. '\n' .. code .. '\n```'
            end,
          },
        },
      },
      ['Fix Code'] = {
        strategy = 'chat',
        description = 'Fix issues in the selected code',
        opts = {
          index = 6,
          default_prompt = true,
          mapping = '<leader>cx',
          modes = { 'v' },
          user_prompt = false,
        },
        prompts = {
          {
            role = 'user',
            content = function(context)
              local code = require('codecompanion.api').get_code(context.start_line, context.end_line)
              return 'Please fix any issues in this code and explain what was wrong:\n\n```' .. context.filetype .. '\n' .. code .. '\n```'
            end,
          },
        },
      },
      ['Refactor Code'] = {
        strategy = 'chat',
        description = 'Refactor the selected code',
        opts = {
          index = 7,
          default_prompt = true,
          mapping = '<leader>cr',
          modes = { 'v' },
          user_prompt = false,
        },
        prompts = {
          {
            role = 'user',
            content = function(context)
              local code = require('codecompanion.api').get_code(context.start_line, context.end_line)
              return 'Please refactor this code to be cleaner and more maintainable:\n\n```' .. context.filetype .. '\n' .. code .. '\n```'
            end,
          },
        },
      },
      ['Generate Tests'] = {
        strategy = 'chat',
        description = 'Generate tests for the selected code',
        opts = {
          index = 8,
          default_prompt = true,
          mapping = '<leader>ct',
          modes = { 'v' },
          user_prompt = false,
        },
        prompts = {
          {
            role = 'user',
            content = function(context)
              local code = require('codecompanion.api').get_code(context.start_line, context.end_line)
              return 'Please generate comprehensive tests for this code:\n\n```' .. context.filetype .. '\n' .. code .. '\n```'
            end,
          },
        },
      },
    },
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = 'Prompt ', -- Prompt used for interactive LLM calls
        provider = 'default', -- Can be "default", "telescope", or "mini_pick". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
        },
      },
      chat = {
        -- Change the default icons
        icons = {
          pinned_buffer = ' ',
          watched_buffer = '👀 ',
        },

        -- Alter the sizing of the debug window
        debug_window = {
          ---@return number|fun(): number
          width = vim.o.columns - 5,
          ---@return number|fun(): number
          height = vim.o.lines - 2,
        },

        -- Options to customize the UI of the chat buffer
        window = {
          layout = 'vertical', -- float|vertical|horizontal|buffer
          position = nil, -- left|right|top|bottom (nil will default depending on vim.opt.plitright|vim.opt.splitbelow)
          border = 'single',
          height = 0.8,
          width = 0.45,
          relative = 'editor',
          full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
          opts = {
            breakindent = true,
            cursorcolumn = false,
            cursorline = false,
            foldcolumn = '0',
            linebreak = true,
            list = false,
            numberwidth = 1,
            signcolumn = 'no',
            spell = false,
            wrap = true,
          },
        },
        auto_scroll = false,
        ---Customize how tokens are displayed
        ---@param tokens number
        ---@param adapter CodeCompanion.Adapter
        ---@return string
        token_count = function(tokens, adapter)
          return ' (' .. tokens .. ' tokens)'
        end,
        intro_message = 'Welcome to CodeCompanion ✨! Press ? for options',
        show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        separator = '─', -- The separator between the different messages in the chat buffer
        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = false, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        start_in_insert_mode = false, -- Open the chat buffer in insert mode?
      },
      diff = {
        enabled = true,
        close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
        layout = 'vertical', -- vertical|horizontal split for default provider
        opts = { 'internal', 'filler', 'closeoff', 'algorithm:patience', 'followwrap', 'linematch:120' },
        provider = 'default', -- default|mini_diff
      },
    },
  },
}
