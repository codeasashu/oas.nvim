## Open API for neovim

This plugin provides support for openapi, such as:

- [x] Previews (via Redoc) 
- [ ] Tree navigator in neovim

### Installation

1. Install redocly cli:
    ```sh 
    npm install -g @redocly/cli
    ```

2. Add the following in lazy.vim:
    ```lua
    -- in lazy.lua
    require("lazy").setup({
      --- other settings
      dev = {
        ---@type string | fun(plugin: LazyPlugin): string directory where you store your local plugin projects
        path = "~/code/personal/plugins",
        ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
        patterns = {}, -- For example {"folke"}
        fallback = false, -- Fallback to git when local plugin doesn't exist
      },
    })
    
    --- in plugins/basic.lua
    
    {
            "oas.nvim",
            dev = true,
            lazy=false,
            config = true
    }
    ```


### Preview

Open review by opening any openapi file and calling command `:OASPreview`. 
To stop the preview, simply call command: `:OASPreviewStop`
