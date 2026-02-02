# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Claude Code plugin that provides skills for initializing and configuring development projects with standardized tooling (mise, pre-commit, commitizen, uv).

## Development Commands

```bash
# Install dependencies (via mise)
mise install

# Run linting
pre-commit run --all-files

# Update pre-commit hooks to latest versions
pre-commit autoupdate
```

## Architecture

### Plugin Structure

- `.claude-plugin/plugin.json` - Plugin manifest defining metadata and hooks
- `commands/*.md` - Skill definitions (5 skills: init, mise-setup, pre-commit-setup, commitizen-setup, uv-setup)
- `hooks/*.sh` - PostToolUse hooks that run on Write|Edit operations

### PostToolUse Hooks

The plugin registers two hooks that trigger on file Write/Edit:
- `pre-commit-autoupdate.sh` - Runs `pre-commit autoupdate` when `.pre-commit-config.yaml` is modified
- `shellcheck.sh` - Runs shellcheck on any modified `.sh` file

### Skill File Format

Skills are markdown files with YAML frontmatter:
```yaml
---
description: Short description for skill discovery
allowed-tools: Read, Bash, Write, Glob, Grep
---
```

The body contains instructions Claude follows when the skill is invoked.

## Tool Philosophy

- mise manages **all** CLI tools (including pre-commit, uv)
- pre-commit installed via mise
- commitizen installed via uv
- uv installed via mise
