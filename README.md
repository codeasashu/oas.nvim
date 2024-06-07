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
    { "codeasashu/oas.nvim" }
    ```


### Preview

Open review by opening any openapi file and calling command `:OASPreview`. 
To stop the preview, simply call command: `:OASPreviewStop`
