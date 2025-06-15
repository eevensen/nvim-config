return {
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      ensure_installed = {
        'prettier',
        'stylua',
        'isort', -- python formatter
        'black', -- python formatter
        'pylint',
        -- 'docker_compose_language_service',
        -- 'dockerls',
        'hadolint',
        'eslint_d',
        'phpcs',
        'phpcbf',
        'twiggy_language_server',
        'yamlls',
        'yamllint',
      },
    },
  },
}
