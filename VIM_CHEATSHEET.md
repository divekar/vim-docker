# Vim C++ Development Cheatsheet

> **Note**: For Neovim with CopilotChat, see additional commands at the bottom.

## Leader Key
**Leader** = `Space`

---

## AI Assistance (GitHub Copilot)

| Key | Action |
|-----|--------|
| `Ctrl-Space` | Accept Copilot suggestion |
| `Alt-J` | Accept next word only |
| `Alt-]` | Next suggestion |
| `Alt-[` | Previous suggestion |
| `:Copilot setup` | Authenticate Copilot |
| `:Copilot enable` | Enable Copilot |
| `:Copilot disable` | Disable Copilot |
| `:Copilot status` | Check Copilot status |

**Note:** Model selection (Claude Sonnet, GPT-4, etc.) is controlled through your [GitHub Copilot settings](https://github.com/settings/copilot), not in Vim.

---

## Code Navigation (coc.nvim + clangd)

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Find all references |
| `K` | Show documentation/hover |
| `Space rn` | Rename symbol |
| `Space fm` | Format selected code (visual mode) |
| `Space o` | Document outline (list functions/classes in current file) |
| `Space S` | Workspace symbols (search all symbols) |
| `Ctrl-o` | Jump back (previous location) |
| `Ctrl-i` | Jump forward (next location) |

### Completion
| Key | Action |
|-----|--------|
| `Tab` | Next completion item |
| `Shift-Tab` | Previous completion item |
| `Enter` | Confirm completion |
| `Ctrl-j` | Jump to next parameter (in snippet) |
| `Ctrl-k` | Jump to previous parameter (in snippet) |

---

## File Navigation

### NERDTree (File Explorer)
| Key | Action |
|-----|--------|
| `Ctrl-n` | Toggle NERDTree |
| `o` | Open file/folder (in NERDTree) |
| `t` | Open in new tab (in NERDTree) |
| `s` | Open in vertical split (in NERDTree) |
| `i` | Open in horizontal split (in NERDTree) |

### FZF (Fuzzy Finder)
| Key | Action |
|-----|--------|
| `Space p` or `Ctrl-p` | Find files by name |
| `Space f` | Search text in all files (ripgrep) |
| `Ctrl-f` | Search text (with prompt) |
| `Space gf` | Search git-tracked files |
| `Space b` | Switch between open buffers |
| `Space /` | Search lines in current file |
| `Space l` | Search lines across all files |
| `Space ph` | Find header files (.h, .hpp) |
| `Space pc` | Find C++ source files (.cpp, .cc, .cxx) |
| `Space pm` | Find makefiles (.mk) |
| `Space pa` | Find all C++ files (headers + sources) |
| `Space fh` | Search text in header files |
| `Space fc` | Search text in C++ source files |
| `Space fmk` | Search text in makefiles |
| `Space fa` | Search text in all C++ files |

**Custom commands:**
- `:FZFHeaders` - Find header files
- `:FZFCpp` - Find C++ source files
- `:FZFMakefiles` - Find makefiles
- `:FZFAllCpp` - Find all C++ files
- `:RgHeaders <query>` - Search text in header files
- `:RgCpp <query>` - Search text in C++ source files
- `:RgMakefiles <query>` - Search text in makefiles
- `:RgAllCpp <query>` - Search text in all C++ files

### C++ Header/Source Switching
| Key | Action |
|-----|--------|
| `Space s` | Switch between .h and .cpp (same window) |
| `Space sh` | Switch between .h and .cpp (split right) |

### Build/Compilation (Quickfix)
| Key | Action |
|-----|--------|
| `Space m` | Build (prompts for target) |
| `Space mm` | Build with last target |
| `Space co` | Open quickfix (error list) |
| `Space cc` | Close quickfix window |
| `Space ce` | Show only errors (hide warnings) |
| `Space ca` | Show all (errors + warnings) |
| `Space cn` or `]q` or `F10` | **Next error (skips warnings)** |
| `Space cp` or `[q` or `F9` | **Previous error (skips warnings)** |
| `Space cN` | Next item (includes warnings) |
| `Space cP` | Previous item (includes warnings) |
| `Space cf` | First error |
| `Space cl` | Last error |

**Workflow:**
1. Press `Space m` - enter target name (e.g., "my_target")
2. Quickfix opens if there are errors/warnings
3. Press `Space ce` to filter and show only errors
4. Navigate with `]q` / `[q` or `Ctrl-j` / `Ctrl-k`
5. Press Enter on error to jump to file/line
6. Fix and repeat with `Space mm` (reuses last target)

**Build Configuration:**
- Command: `./docker-build.sh <target>`
- Environment: `BUILD_SCLS=gcc-toolset-11`, `PLATFORM=AS8`
- Edit `.vimrc` to change build command or environment variables

---

## Git Integration

### Git Commands
| Key | Action |
|-----|--------|
| `Space gs` | Git status |
| `Space gd` | Git diff (vertical split) |
| `Space gb` | Git blame (same window) |
| `Space gB` | Git blame (split) |
| `Space gl` | Git log for current file |
| `Space gL` | Git log (all commits) |
| `Space gw` | Stage current file (git add) |
| `Space gR` | Discard changes (git checkout) |

### GitGutter (Change Navigation)
| Key | Action |
|-----|--------|
| `]h` | Jump to next change (hunk) |
| `[h` | Jump to previous change (hunk) |
| `Space gh` | Preview hunk changes |
| `Space ga` | Stage current hunk |
| `Space gu` | Undo current hunk |

**Gutter Symbols:**
- `+` Added lines
- `~` Modified lines
- `-` Deleted lines

---

## General Editing

### Quick Actions
| Key | Action |
|-----|--------|
| `Space w` | Save file |
| `Space q` | Quit |
| `Space Space` | Clear search highlighting |

### Split Navigation
| Key | Action |
|-----|--------|
| `Ctrl-h` | Move to left split |
| `Ctrl-j` | Move to down split |
| `Ctrl-k` | Move to up split |
| `Ctrl-l` | Move to right split |

### Code Commenting
| Key | Action |
|-----|--------|
| `gcc` | Toggle comment on current line |
| `gc` | Toggle comment (visual mode) |

### Code Formatting
| Key | Action |
|-----|--------|
| `Space fm` | Format selected code (visual mode) |

**Note:** Auto-format on save is **disabled** by default to preserve your code formatting.
- To format entire file: `:CocCommand clangd.format`
- To enable auto-format on save: Edit `coc-settings.json`

---

## Vim Built-in Commands

### Basic Movement
| Key | Action |
|-----|--------|
| `h/j/k/l` | Left/Down/Up/Right |
| `w` | Next word |
| `b` | Previous word |
| `0` | Start of line |
| `$` | End of line |
| `gg` | Go to first line |
| `G` | Go to last line |
| `{line}G` | Go to line number |
| `Ctrl-d` | Page down |
| `Ctrl-u` | Page up |

### Editing
| Key | Action |
|-----|--------|
| `i` | Insert mode (before cursor) |
| `a` | Insert mode (after cursor) |
| `o` | New line below and insert |
| `O` | New line above and insert |
| `v` | Visual mode (character) |
| `V` | Visual mode (line) |
| `Ctrl-v` | Visual block mode |
| `y` | Yank (copy) |
| `yy` | Yank current line |
| `d` | Delete |
| `dd` | Delete current line |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `Ctrl-r` | Redo |
| `.` | Repeat last command |

### Search & Replace
| Key | Action |
|-----|--------|
| `/pattern` | Search forward |
| `?pattern` | Search backward |
| `n` | Next search result |
| `N` | Previous search result |
| `*` | Search word under cursor |
| `:s/old/new/g` | Replace in current line |
| `:%s/old/new/g` | Replace in entire file |
| `:%s/old/new/gc` | Replace with confirmation |

### Windows & Tabs
| Key | Action |
|-----|--------|
| `:sp` | Horizontal split |
| `:vsp` | Vertical split |
| `:tabnew` | New tab |
| `gt` | Next tab |
| `gT` | Previous tab |
| `:q` | Close window |
| `:qa` | Close all windows |

---

## Useful Commands

### Vim Commands
```vim
:PlugStatus           " Check plugin status
:PlugInstall          " Install plugins
:PlugUpdate           " Update plugins
:CocInfo              " coc.nvim diagnostics
:CocConfig            " Edit coc-settings.json
:checkhealth          " Check Vim health
:set paste            " Enable paste mode (no autoindent)
:set nopaste          " Disable paste mode
:set number!          " Toggle line numbers
:syntax sync fromstart " Fix syntax highlighting
```

### Shell Commands
```vim
:!git status          " Run git status
:!make                " Run make
:r !ls                " Insert command output
```

---

## Project Setup Tips

### For Best C++ Intelligence
1. Place `compile_commands.json` in project root or build directory
2. Create `.clangd` file in project root:
   ```yaml
   CompilationDatabase: build/
   ```
3. Open Vim from project root directory

### Check clangd Status
```vim
:CocCommand clangd.restart
:CocInfo
```

### Refresh File Tree
In NERDTree, press `r` to refresh current directory or `R` to refresh root.

---

## Quick Reference Card

**Most Common Actions:**
- `Space p` → Find file
- `Space f` → Search text
- `gd` → Go to definition  
- `Ctrl-o` → Go back
- `Space gs` → Git status
- `Space gb` → Git blame
- `Ctrl-n` → File tree
- `Space o` → Code outline

---

## Color Themes

**Default:** Catppuccin Mocha (dark theme optimized for C++)

**Available in both Vim and Neovim:**
- **Catppuccin** - Modern pastel theme
- **Tokyo Night** - VS Code inspired dark theme
- **Nightfox** - Customizable dark theme
- **One Dark** - Atom's iconic theme
- **Dracula** - Popular dark theme

**Switch themes at runtime:**
```vim
:colorscheme catppuccin_mocha  " Catppuccin (default)
:colorscheme tokyonight        " Tokyo Night
:colorscheme nightfox          " Nightfox
:colorscheme onedark           " One Dark
:colorscheme dracula           " Dracula
```

**Make permanent:** Edit `.vimrc` (Vim) or `init.lua` (Neovim)

---

## Neovim Only: CopilotChat Commands

**Available only when using Neovim (Dockerfile.neovim)**

### Interactive Chat

| Shortcut | Command | Description |
|----------|---------|-------------|
| `Space cc` | `:CopilotChatToggle` | Open/close chat window |
| `Space ce` | `:CopilotChatExplain` | Explain selected code |
| `Space cr` | `:CopilotChatReview` | Review code for issues |
| `Space cf` | `:CopilotChatFix` | Fix bugs in code |
| `Space co` | `:CopilotChatOptimize` | Optimize performance |
| `Space cd` | `:CopilotChatDocs` | Generate documentation |
| `Space ct` | `:CopilotChatTests` | Generate unit tests |

**Usage:**
1. Select code with `v` or `V` (visual mode)
2. Press `Space` + one of the shortcuts above
3. Chat window opens with AI response
4. Type follow-up questions in chat window

**Model:** Configured to use Claude Sonnet 3.5

See [README_NEOVIM.md](README_NEOVIM.md) for complete Neovim setup instructions.