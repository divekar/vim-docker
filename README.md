# Vim/Neovim C++ Development Docker Images

Docker images for C++ development with Vim or Neovim, featuring clangd LSP, GitHub Copilot, and comprehensive development tools.

## Quick Start

### Vim (with inline Copilot completions)
```bash
# Build
docker build --platform linux/amd64 -t vim-centos8-dev ./vim/

# Run
docker run -it --rm -v $(pwd):/workspace vim-centos8-dev
```

### Neovim (with CopilotChat)
```bash
# Build
docker build --platform linux/amd64 -t nvim-centos8-dev ./nvim/

# Run
docker run -it --rm -v $(pwd):/workspace nvim-centos8-dev
``

## Features

### Common Features (Both Vim & Neovim)
- **Base**: CentOS 8 with gcc, g++, git, python3, curl, clangd
- **C++ LSP**: coc.nvim + coc-clangd for intelligent code completion
- **Navigation**: Go to definition, find references, rename symbols
- **File Management**: NERDTree, fzf fuzzy finder, ripgrep text search
- **Git Integration**: vim-fugitive, vim-gitgutter
- **Code Tools**: Tagbar, vim-commentary, header/source switching
- **GitHub Copilot**: Inline code completions

### Neovim Exclusive
- **CopilotChat**: Interactive AI chat with Claude Sonnet 3.5
  - Code explanation, review, optimization
  - Bug fixes and test generation
  - Documentation generation

## Usage Examples

### Open a specific file
``bash
docker run -it --rm -v /path/to/project:/workspace vim-centos8-dev vim main.cpp
```

### With shell access
```bash
docker run -it --rm -v $(pwd):/workspace --entrypoint /bin/bash nvim-centos8-dev
```

### Mounting compile_commands.json
```bash
docker run -it --rm \
  -v $(pwd):/workspace \
  -v $(pwd)/build/compile_commands.json:/workspace/compile_commands.json \
  nvim-centos8-dev
```

## First-Time Setup

### Authenticate GitHub Copilot
Inside Vim/Neovim:
```vim
:Copilot setup
```
Follow the browser authentication flow.

### Configure compile_commands.json Path
Create `.clangd` in your project root:
```yaml
CompilationDatabase: build/
``


## Updating

### Rebuild from scratch
``bash
# Vim
docker build --no-cache --platform linux/amd64 -t vim-centos8-dev ./vim/

# Neovim
docker build --no-cache --platform linux/amd64 -t nvim-centos8-dev ./nvim/
```

### Update plugins inside container
```vim
:PlugUpdate
:CocUpdate
```