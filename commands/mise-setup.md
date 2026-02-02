---
description: Configure mise (formerly rtx) for managing tool versions in a project. Use when setting up a new project, adding runtime versions, or configuring development tools like Node.js, Python, Ruby, Go, etc.
allowed-tools: Read, Bash, Write, Glob
---

# Mise Setup

Configure [mise](https://mise.jdx.dev/) for managing tool versions in this project.

## Instructions

1. **Check if mise is installed**
   - Run `mise --version`
   - If not installed, inform the user to install it via their package manager or `curl https://mise.run | sh`

2. **Check for existing configuration**
   - Look for `.mise.toml` or `.tool-versions` in the project root
   - If exists, read and understand current configuration

3. **Analyze the project to detect required tools**
     - `package.json` → Node.js
     - `pyproject.toml`, `setup.py`, `requirements.txt` → Python
     - `Gemfile` → Ruby
     - `go.mod` → Go
   - `Cargo.toml` → Rust
   - Suggest appropriate versions based on project constraints

4. **Create or update `.mise.toml`**
   - Prefer `.mise.toml` over `.tool-versions` for richer configuration
   - Include recommended settings:

     ```toml
     [settings]
     experimental = true

     [tools]
     # tool = "version"
     ```

5. **Activate mise**
   - Run `mise trust` to trust the configuration
   - Run `mise install` to install all tools

## Example `.mise.toml`

```toml
[settings]
experimental = true

[tools]
python = "3.12"
node = "20"
```

## Reference

- Documentation: <https://mise.jdx.dev/>
- Available plugins: `mise plugins ls-remote`
- List installed tools: `mise ls`
