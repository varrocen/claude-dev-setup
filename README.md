# claude-dev-setup

Claude Code plugin to initialize and configure development projects with standardized tooling.

## Installation

```bash
# Add the marketplace (once)
/plugin marketplace add varrocen/claude-dev-setup

# Install the plugin
/plugin install dev-setup@varrocen-marketplace --scope user
```

## Available Skills

| Skill | Description |
|-------|-------------|
| `/dev-setup:init` | Full project initialization (all tools) |
| `/dev-setup:mise-setup` | Configure [mise](https://mise.jdx.dev/) |
| `/dev-setup:pre-commit-setup` | Configure [pre-commit](https://pre-commit.com/) |
| `/dev-setup:commitizen-setup` | Configure [commitizen](https://commitizen-tools.github.io/commitizen/) |
| `/dev-setup:uv-setup` | Configure [uv](https://github.com/astral-sh/uv) (Python) |

## Usage

### Initialize a new project

```bash
/dev-setup:init           # Auto-detect project type
/dev-setup:init python    # Force Python setup
```

### Configure a specific tool

```bash
/dev-setup:mise-setup python@3.12 node@20
/dev-setup:uv-setup add httpx pydantic
/dev-setup:pre-commit-setup ruff
```

## Configured Tools

- **mise**: Tool version manager (replaces asdf, nvm, pyenv, etc.)
- **pre-commit**: Git hooks for code quality
- **commitizen**: Standardized commit messages (Conventional Commits)
- **uv**: Ultra-fast Python package manager

## Philosophy

- mise for **all** CLI tools
- pre-commit installed via mise
- commitizen installed via uv
- uv installed via mise
