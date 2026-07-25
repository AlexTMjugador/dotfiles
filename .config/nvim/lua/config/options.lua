-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Force a dark background/theme
vim.o.background = "dark"

-- We want to use the Ioskeley Mono font, patched with all the Nerd Font symbols
-- (Font Awesome, Powerline, Devicons, Material Design, Codeicons...), for all
-- of LazyVim icons to render properly and be consistent with the font we also
-- use in our terminal. Ioskeley Mono Nerd Font does not come preinstalled with
-- many distributions, so we usually have to install it manually:
--
-- - Linux: drop IoskeleyMono Nerd Font files to ~/.local/share/fonts (done
-- automatically when cloning the dotfiles), then run `fc-cache -fv` and make
-- sure the terminal is set up to use it (should also be taken care of by
-- dotfiles).
-- - macOS: drag all IoskeleyMono Nerd Font files into the Font Book.
--
-- References:
-- - https://ahatem.github.io/IoskeleyMono
-- - https://www.nerdfonts.com
vim.o.guifont = "IoskeleyMono Nerd Font:h14"

-- The SHELL environment variable may not be set in devcontainers, so Neovim may
-- default to /bin/sh. For interactive purposes, however, we want to default to
-- zsh if available, then bash, and finally /bin/sh as a last resort
for _, sh in ipairs({ "/bin/zsh", "/bin/bash", "/bin/sh" }) do
  if vim.fn.executable(sh) == 1 then
    vim.o.shell = sh
    break
  end
end

-- The Ansible LSP requires proper filetype assignment to take priority over the
-- general YAML LSP server. Docker Compose files are also affected. We also add
-- a "redis" filetype, used by dadbod, for Redis commands highlighting in
-- conjunction with our custom redis syntax
vim.filetype.add({
  pattern = {
    [".*/.*[.]ansible[.]ya?ml"] = "yaml.ansible",
    [".*/compose[.]ya?ml"] = "yaml.docker-compose",
    [".*/compose[.][^.]+[.]ya?ml"] = "yaml.docker-compose",
    [".*/.*[.]redis"] = "redis",
  },
})

-- Enable custom LSP servers not enabled by mason-lspconfig, using the built-in
-- Neovim LSP support, https://neovim.io/doc/user/lsp/, which deprecates
-- neovim/nvim-lspconfig
vim.lsp.enable("make-ls")

-- Initialize codesettings for project-specific LSP configuration, for all LSPs
vim.lsp.config("*", {
  before_init = function(_, config)
    require("codesettings").with_local_settings(config.name, config)
  end,
})
