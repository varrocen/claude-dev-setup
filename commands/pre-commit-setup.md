---
description: Configure pre-commit hooks for a project. Use when setting up code quality checks, linters, formatters, or automated validations that run before each commit.
allowed-tools: Read, Bash, Write, Glob, Grep
---

# Pre-commit Setup

Configure [pre-commit](https://pre-commit.com/) hooks for this project.

## Instructions

1. **Check if pre-commit is installed**
   - Run `pre-commit --version`
   - If not installed: `mise use pre-commit`

2. **Check for existing configuration**
   - Look for `.pre-commit-config.yaml` in project root
   - If exists, read and understand current hooks

3. **Analyze the project to determine appropriate hooks**
   - Detect languages present in the project (check file extensions, package files)
   - **Always add linters/formatters for each detected language:**
     - Python → ruff, ruff-format, mypy, bandit
     - JavaScript/TypeScript → prettier, eslint
     - Go → go-fmt, go-vet, golangci-lint
     - Rust → rustfmt, clippy
     - Shell scripts → shellcheck
   - General → trailing-whitespace, end-of-file-fixer, check-yaml, check-json, check-toml

4. **Create or update `.pre-commit-config.yaml`**
   - Group related hooks together
   - Add comments explaining each hook's purpose
   - Run `pre-commit autoupdate` to ensure all hooks use the latest stable versions

5. **Install the hooks**
   - Run `pre-commit install` to set up the git hooks
   - Optionally run `pre-commit install --hook-type commit-msg` for commit message hooks

6. **Run initial check**
   - Run `pre-commit run --all-files` to validate on existing code
   - If shellcheck fails with Docker error, ask user to start Docker and retry
   - Report any issues found

## Example Configuration

```yaml
repos:
  # General hooks
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-json
      - id: check-toml
      - id: check-added-large-files
      - id: check-merge-conflict

  # Python (using ruff for linting and formatting)
  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.8.0
    hooks:
      - id: ruff
        args: [--fix]
      - id: ruff-format

  # Commit message validation (works with commitizen)
  - repo: https://github.com/commitizen-tools/commitizen
    rev: v4.1.0
    hooks:
      - id: commitizen
```

## Reference

- Documentation: <https://pre-commit.com/>
- Available hooks: <https://pre-commit.com/hooks.html>
- Update hooks: `pre-commit autoupdate`
