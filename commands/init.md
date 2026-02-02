---
description: Initialize a complete development project with mise, pre-commit, commitizen, and uv (for Python projects). Use when starting a new project or adding standard tooling to an existing one.
allowed-tools: Read, Bash, Write, Glob, Grep
---

# Project Initialization

Set up a complete development environment with standardized tooling.

## Instructions

Execute each step sequentially:

### 1. Detect project type

Analyze the project to determine its type:

- `pyproject.toml`, `setup.py`, `requirements.txt` → Python project
- `package.json` → Node.js project
- `go.mod` → Go project
- `Cargo.toml` → Rust project

### 2. Configure mise

- Check if mise is installed, if not inform user to install it
- Create or update `.mise.toml` with appropriate tools:
  - Always add: `pre-commit`
  - For Python projects: add `python` and `uv`
  - For Node.js projects: add `node`
  - For Go projects: add `go`
  - For Rust projects: add `rust`
- Do NOT add `[settings]` section (e.g., `experimental = true`) unless explicitly required
- Run `mise trust` and `mise install`

### 3. Configure pre-commit

- Create `.pre-commit-config.yaml` with hooks appropriate for the project type:
  - General: trailing-whitespace, end-of-file-fixer, check-yaml, check-added-large-files
  - Shell scripts: shellcheck
  - Python: ruff, ruff-format
  - Node.js: prettier, eslint (if configured)
  - Go: go-fmt, go-vet
- Include commitizen hook for commit message validation
- Run `pre-commit install`
- Run `pre-commit install --hook-type commit-msg`

### 4. Configure commitizen

- Do NOT create `.cz.toml` by default (commitizen defaults are sufficient)
- For Python projects: only add `[tool.commitizen]` to `pyproject.toml` if custom settings are needed
- The commitizen hook in pre-commit is enough to validate commit messages

### 5. Configure uv (Python projects only)

- If Python project detected:
  - Check if uv is installed via mise
  - If `pyproject.toml` doesn't exist, run `uv init`
  - Add dev dependencies: `uv add --dev pytest ruff mypy pre-commit`
  - Run `uv sync`

### 6. Final verification

- Run `pre-commit run --all-files` to validate setup
- Report any issues found
- Summarize what was configured

## Example output

After running `/dev-setup:init` on a Python project:

```
.mise.toml                 # Tool versions (python, uv, pre-commit)
.pre-commit-config.yaml    # Pre-commit hooks
pyproject.toml             # Project configuration
uv.lock                    # Dependency lock file
.venv/                     # Virtual environment
```
