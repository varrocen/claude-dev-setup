---
name: init
description: Initialize a complete development project with mise, pre-commit, commitizen, and uv (for Python projects). Use when starting a new project or adding standard tooling to an existing one.
argument-hint: [python] (optional, to force Python setup)
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
- If `$ARGUMENTS` contains "python" → Force Python project

### 2. Configure mise

- Check if mise is installed, if not inform user to install it
- Create or update `.mise.toml` with appropriate tools:
  - Always add: `pre-commit`
  - For Python projects: add `python` and `uv`
  - For Node.js projects: add `node`
  - For Go projects: add `go`
  - For Rust projects: add `rust`
- Run `mise trust` and `mise install`

### 3. Configure pre-commit

- Create `.pre-commit-config.yaml` with hooks appropriate for the project type:
  - General: trailing-whitespace, end-of-file-fixer, check-yaml, check-added-large-files
  - Python: ruff, ruff-format
  - Node.js: prettier, eslint (if configured)
  - Go: go-fmt, go-vet
- Include commitizen hook for commit message validation
- Run `pre-commit install`
- Run `pre-commit install --hook-type commit-msg`

### 4. Configure commitizen

- Add commitizen configuration to `pyproject.toml` (Python) or create `.cz.toml` (other)
- Configure:
  ```toml
  [tool.commitizen]
  name = "cz_conventional_commits"
  tag_format = "v$version"
  version_scheme = "pep440"
  update_changelog_on_bump = true
  major_version_zero = true
  ```

### 5. Configure uv (Python projects only)

- If Python project detected or forced:
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
pyproject.toml             # Updated with commitizen config
uv.lock                    # Dependency lock file
.venv/                     # Virtual environment
```
