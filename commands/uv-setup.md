---
description: Configure uv for Python project management. Use when creating a new Python project, migrating from pip/poetry/pipenv, managing dependencies, or setting up virtual environments.
argument-hint: [command] (e.g., init, add package-name, sync)
allowed-tools: Read, Bash, Write, Glob, Grep
---

# UV Setup

Configure [uv](https://github.com/astral-sh/uv) for Python project management.

## Instructions

1. **Check if uv is installed**
   - Run `uv --version`
   - If not installed: `mise use uv`

2. **Determine the action needed**

### New Project ($ARGUMENTS contains "init")
- Run `uv init` to create a new project
- This creates `pyproject.toml`, `.python-version`, and `hello.py`

### Existing Project
- Check for existing configuration:
  - `pyproject.toml` with `[project]` section
  - `requirements.txt`
  - `setup.py` / `setup.cfg`
  - `Pipfile`
  - `poetry.lock`

3. **Migration from other tools**

**From requirements.txt:**
```bash
uv add $(cat requirements.txt)
```

**From Poetry:**
```bash
# uv can read poetry's pyproject.toml directly
uv sync
```

**From Pipenv:**
```bash
# Convert Pipfile to requirements and then to uv
uv pip compile Pipfile -o requirements.txt
uv add -r requirements.txt
```

4. **Configure `pyproject.toml`**
   - Ensure proper project metadata
   - Add dev dependencies group if needed

5. **Set up virtual environment**
   - uv automatically creates `.venv` when needed
   - Run `uv sync` to install all dependencies

6. **If arguments specify packages ($ARGUMENTS)**
   - `uv add <package>` for runtime dependencies
   - `uv add --dev <package>` for development dependencies
   - `uv remove <package>` to remove dependencies

## Common Commands

| Command | Description |
|---------|-------------|
| `uv init` | Create new project |
| `uv add <pkg>` | Add dependency |
| `uv add --dev <pkg>` | Add dev dependency |
| `uv remove <pkg>` | Remove dependency |
| `uv sync` | Sync dependencies |
| `uv lock` | Update lock file |
| `uv run <cmd>` | Run command in venv |
| `uv pip install` | pip-compatible install |
| `uv tool install <pkg>` | Install CLI tool globally |
| `uv python install 3.12` | Install Python version |

## Example `pyproject.toml`

```toml
[project]
name = "my-project"
version = "0.1.0"
description = "My Python project"
readme = "README.md"
requires-python = ">=3.11"
dependencies = [
    "httpx>=0.27",
    "pydantic>=2.0",
]

[dependency-groups]
dev = [
    "pytest>=8.0",
    "ruff>=0.8",
    "mypy>=1.13",
    "pre-commit>=4.0",
]

[build-system]
requires = ["hatchling"]
build-backend = "hatchling.build"

[tool.ruff]
line-length = 88
target-version = "py311"

[tool.ruff.lint]
select = ["E", "F", "I", "UP", "B", "SIM"]

[tool.mypy]
python_version = "3.11"
strict = true
```

## Integration with mise

Add Python via mise for consistent versions:
```toml
# .mise.toml
[tools]
python = "3.12"
uv = "latest"
```

## Reference

- Documentation: https://docs.astral.sh/uv/
- GitHub: https://github.com/astral-sh/uv
- Migration guide: https://docs.astral.sh/uv/guides/migration/
