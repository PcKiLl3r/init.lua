# Neovim Configuration Dependencies

This document lists all external tools and dependencies required for the full Neovim configuration to work properly.

## Core Requirements

### Neovim
```bash
# Install Neovim (>= 0.9.0)
# Fedora
sudo dnf install neovim

# Or build from source for latest
```

### Node.js & Package Managers
```bash
# Node.js 20.x (required for LSP servers and formatters)
sudo dnf install nodejs npm

# pnpm (optional but recommended)
npm install -g pnpm
```

## Language Servers (Mason will auto-install these)

The following LSP servers are configured in `lsp.lua`:
- `lua_ls` - Lua Language Server
- `rust_analyzer` - Rust Language Server
- `gopls` - Go Language Server
- `zls` - Zig Language Server (optional)

## Formatters (Required for conform.nvim)

### JavaScript/TypeScript/Web
```bash
npm install -g prettier
```

### Python
```bash
pip install black
```

### Shell Scripts
```bash
# Fedora
sudo dnf install shfmt

# Or via Go
go install mvdan.cc/sh/v3/cmd/shfmt@latest
```

### C/C++
```bash
# Fedora
sudo dnf install clang-tools-extra

# This provides clang-format
```

### Lua
```bash
# Install via Cargo (Rust package manager)
cargo install stylua
```

### Go
```bash
# gofmt comes with Go installation
sudo dnf install golang
```

### Rust
```bash
# rustfmt comes with Rust installation
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

### Java
```bash
# Download google-java-format jar
wget https://github.com/google/google-java-format/releases/download/v1.19.2/google-java-format-1.19.2-all-deps.jar
# Place in ~/.local/bin/ or similar
```

### PHP
```bash
composer global require friendsofphp/php-cs-fixer
```

### Ruby
```bash
gem install rubocop
```

### SQL
```bash
pip install sqlfluff
```

### XML
```bash
pip install xmlformatter
```

### Docker
```bash
# For Dockerfile linting
# Install via binary or package manager
wget -O hadolint https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
chmod +x hadolint
sudo mv hadolint /usr/local/bin/
```

## Debugging (DAP)

### General
- `js-debug-adapter` (install via Mason: `:Mason`)

### Go Debugging
```bash
# Delve debugger
go install github.com/go-delve/delve/cmd/dlv@latest
```

## Testing (Neotest)

### Deno (for Peek markdown preview)
```bash
curl -fsSL https://deno.land/install.sh | sh
```

## Terminal Tools (Optional but recommended)

```bash
# Fedora packages
sudo dnf install ripgrep fd-find git

# These enhance telescope and general workflow
```

## Ansible Playbook Commands

For your `linux-dev-playbook`, here are the consolidated commands:

```yaml
# Package managers and core tools
- name: Install core development tools
  dnf:
    name:
      - neovim
      - nodejs
      - npm
      - golang
      - git
      - ripgrep
      - fd-find
      - shfmt
      - clang-tools-extra
    state: present

# Python formatters
- name: Install Python formatters
  pip:
    name:
      - black
      - sqlfluff
      - xmlformatter

# Node.js global packages
- name: Install Node.js formatters
  npm:
    name: prettier
    global: yes

# Rust toolchain (includes rustfmt)
- name: Install Rust
  shell: curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  args:
    creates: ~/.cargo/bin/rustc

# Cargo packages
- name: Install Rust formatters
  shell: ~/.cargo/bin/cargo install stylua
  args:
    creates: ~/.cargo/bin/stylua

# Go tools
- name: Install Go debugger
  shell: go install github.com/go-delve/delve/cmd/dlv@latest
  environment:
    GOPATH: "{{ ansible_env.HOME }}/go"

# Deno for markdown preview
- name: Install Deno
  shell: curl -fsSL https://deno.land/install.sh | sh
  args:
    creates: ~/.deno/bin/deno

# Hadolint for Dockerfile linting
- name: Install Hadolint
  get_url:
    url: https://github.com/hadolint/hadolint/releases/download/v2.12.0/hadolint-Linux-x86_64
    dest: /usr/local/bin/hadolint
    mode: '0755'
```

## Verification Commands

After installation, verify everything works:

```bash
# Check formatters
stylua --version
prettier --version
black --version
shfmt --version
clang-format --version

# Check LSP tools (these will be installed by Mason)
# Open Neovim and run :Mason to install language servers

# Check debugging tools
dlv version
deno --version
```
````
