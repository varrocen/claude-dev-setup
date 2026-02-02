---
name: commitizen-setup
description: Configure commitizen for standardized commit messages following Conventional Commits. Use when setting up a project for consistent commit history, changelog generation, or semantic versioning.
argument-hint: [bump-type] (e.g., major, minor, patch)
allowed-tools: Read, Bash, Write, Glob, Grep
---

# Commitizen Setup

Configure [commitizen](https://commitizen-tools.github.io/commitizen/) for standardized commit messages.

## Instructions

1. **Check if commitizen is installed**
   - Run `cz version`
   - If not installed: `uv tool install commitizen` or `uv add --dev commitizen`

2. **Check for existing configuration**
   - Look for commitizen config in:
     - `pyproject.toml` → `[tool.commitizen]` section
     - `.cz.toml`
     - `cz.json`
     - `.cz.json`
   - If exists, read and understand current configuration

3. **Configure commitizen**
   - Prefer `pyproject.toml` for Python projects
   - Otherwise use `.cz.toml`

4. **Standard configuration options**
   ```toml
   [tool.commitizen]
   name = "cz_conventional_commits"
   tag_format = "v$version"
   version_scheme = "pep440"
   version_provider = "pep621"
   update_changelog_on_bump = true
   major_version_zero = true
   ```

5. **If project has a version file, configure version tracking**
   - For Python (`pyproject.toml`): `version_provider = "pep621"`
   - For Node.js (`package.json`): `version_provider = "npm"`
   - For other: `version_files = ["src/__version__.py:__version__"]`

6. **Integrate with pre-commit (required)**
   - Add commitizen hook to `.pre-commit-config.yaml`:
     ```yaml
     - repo: https://github.com/commitizen-tools/commitizen
       rev: v4.1.0
       hooks:
         - id: commitizen
         - id: commitizen-branch
           stages: [pre-push]
     ```

7. **Initialize changelog if needed**
   - Run `cz changelog --dry-run` to preview
   - Run `cz changelog` to generate `CHANGELOG.md`

## Commit Message Format

Conventional Commits format:
```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature (MINOR version bump)
- `fix`: Bug fix (PATCH version bump)
- `docs`: Documentation only
- `style`: Code style (formatting, semicolons, etc.)
- `refactor`: Code refactoring
- `perf`: Performance improvement
- `test`: Adding tests
- `build`: Build system changes
- `ci`: CI configuration
- `chore`: Maintenance tasks

**Breaking changes:** Add `!` after type or `BREAKING CHANGE:` in footer (MAJOR version bump)

## Usage

- Interactive commit: `cz commit` or `cz c`
- Bump version: `cz bump`
- Generate changelog: `cz changelog`
- Check commits: `cz check --rev-range HEAD~5..HEAD`

## Example `pyproject.toml`

```toml
[tool.commitizen]
name = "cz_conventional_commits"
tag_format = "v$version"
version_scheme = "pep440"
version_provider = "pep621"
update_changelog_on_bump = true
major_version_zero = true
```

## Reference

- Documentation: https://commitizen-tools.github.io/commitizen/
- Conventional Commits: https://www.conventionalcommits.org/
