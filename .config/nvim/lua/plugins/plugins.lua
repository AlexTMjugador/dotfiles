return {
  -- Devcontainer support
  {
    "erichlf/devcontainer-cli.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    init = function()
      local dotfiles_branch_cmd = vim
        .system(
          { "git", "--git-dir", vim.fn.expand("~/.dotfiles"), "branch", "--show-current" },
          { text = true, stderr = false, timeout = 7000 }
        )
        :wait(10000)

      local current_dotfiles_branch
      if dotfiles_branch_cmd.code == 0 then
        current_dotfiles_branch = dotfiles_branch_cmd.stdout
      else
        current_dotfiles_branch = nil
      end

      require("devcontainer-cli").setup({
        interactive = false,
        -- Uses the devcontainer CLI dotfiles support: https://github.com/devcontainers/cli/pull/362
        -- The way the repository URL parameter is concatenated with the remaining Git CLI args is
        -- usefully vulnerable to injecting additional switches, including the -b switch used by
        -- dotfiles_branch below.
        dotfiles_repository = "https://github.com/AlexTMjugador/dotfiles.git",
        dotfiles_branch = current_dotfiles_branch,
        dotfiles_targetPath = "/tmp/.dotfiles",
        dotfiles_installCommand = ".config/devcontainer-dotfiles/install.sh",
        shell = "sh",
      })
      require("config.devcontainer_reopen").setup()
    end,
  },

  -- Git support
  { "sindrets/diffview.nvim" },
  { "lewis6991/gitsigns.nvim", opts = { current_line_blame = true } },
  {
    "afonsofrancof/worktrees.nvim",
    event = "VeryLazy",
    opts = {
      base_path = "../..", -- Relative to .git dir

      path_template = "worktree-{branch}",

      mappings = {
        create = "<leader>gwc",
        delete = "<leader>gwd",
        switch = "<leader>gws",
      },
    },
  },

  -- LSP support
  {
    "mrjones2014/codesettings.nvim",
    opts = { live_reload = true },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- Required for Nix linting and formatting with the Nix extra
        "statix",
        "nixfmt",
        -- Required for grug-far
        "ast-grep",
        -- Required for LSP servers to work.
        -- make-ls is not in Mason yet, it should be provided externally
        "typos-lsp",
        "graphql-language-service-cli",
        -- XML language server
        "lemminx",
        -- TOML language server
        "tombi",
        -- HTML language server
        "html-lsp",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      if opts.servers then
        -- LazyVim's sidekick plugin enables the Copilot LSP server, which
        -- causes Mason to install it and a relatively heavyweight Node
        -- server to be launched as soon as a file is opened. We don't
        -- want to use such language server, so let's force-disable it.
        -- See: https://github.com/folke/sidekick.nvim/issues/231,
        -- https://www.lazyvim.org/extras/ai/sidekick#nvim-lspconfig
        opts.servers.copilot = nil
      end
    end,
  },
  {
    -- Patch nvim-jdtls with a pull request that improves its behavior on
    -- standalone Java projects. This patch can be removed once the PR gets
    -- merged or superseded. Ref:
    -- https://codeberg.org/mfussenegger/nvim-jdtls/pulls/26
    url = "https://codeberg.org/AlexTMjugador/nvim-jdtls.git",
    branch = "fix/jdtls-invisible-project-importer-compat",
  },

  -- Customize the status line with different buttons
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections.lualine_z = {
        {
          function()
            return ""
          end,
          cond = function()
            return vim.uv.fs_stat("/.dockerenv") ~= nil
          end,
        },
      }
    end,
  },

  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        -- By default, show hidden and Git-ignored files
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
          files = {
            hidden = true,
            ignored = true,
          },
        },
      },
    },
  },

  -- Use the gruvbox theme
  { "ellisonleao/gruvbox.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },
}
