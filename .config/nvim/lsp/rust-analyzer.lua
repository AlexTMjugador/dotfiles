return {
  ---@type lspconfig.settings.rust_analyzer
  default_settings = {
    ["rust-analyzer"] = {
      cargo = {
        -- This rust-analyzer flag is deprecated, but LazyVim still sets it and it
        -- changes RA's stock feature resolution behavior, so explicitly disable it.
        -- Reference: https://www.lazyvim.org/extras/lang/rust#rustaceanvim
        allFeatures = false,
      },
    },
  },
}
