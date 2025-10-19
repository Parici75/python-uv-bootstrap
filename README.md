# Python uv + Hatch bootstrap template
> *Author: [Benjamin Roland](https://www.github.com/parici75)*


This repository provides a **lightweight and modern Python project template** powered by:

- ⚡ **[uv](https://github.com/astral-sh/uv)** – ultra-fast dependency & virtual environment manager
- 🛠 **[Hatch](https://hatch.pypa.io/)** – build backend and version management
- 🧰 A convenient **`Makefile`** for CI command automation


## 🚦 Requirements

Install **uv** if not already installed:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
````

Then, assuming you have a Unix shell with `make`, use the following target to set up a new uv-managed replicable environment for your project :
```bash
make init
```

## 👷 CI/CD tools
- 🚀 Package management tool: [uv](https://github.com/astral-sh/uv)
- 🎭 Code formatting and linting: [ruff](https://docs.astral.sh/ruff/)
- 🔎 Static typing: [mypy](https://mypy.readthedocs.io/en/stable/)
- 🧪 Tests: [pytest](https://docs.pytest.org/en/latest/)
- 📤 [pre-commit](https://pre-commit.com/) hooks


All tools configurations live in a single `pyproject.toml` — no scattered files.


## 🔖 Dynamic Versioning
[uv-dynamic-versioning](https://github.com/ninoseki/uv-dynamic-versioning/) is used to enforce VCS tags as a single source of truth for project versioning.


## 📤 Pre-commit hooks
Pre-commit hooks prevent code with identified issues to be committed and submitted for code review.
We use :
- [built-in](https://pre-commit.com/hooks.html) pre-commit hooks for common linting/code quality checks.
- [pyupgrade](https://github.com/asottile/pyupgrade) to keep up with PEP syntax upgrade.
- [Ruff formatter](https://docs.astral.sh/ruff/formatter/) for proper code formatting.
- [Ruff linter](https://docs.astral.sh/ruff/linter/) and [mypy](https://mypy.readthedocs.io/en/stable/) hooks to catch code quality issues early.


## 📝 Documentation
The template ships with a pre-built documentation structure for [Sphinx](https://www.sphinx-doc.org/en/master/), with [Autodoc](https://www.sphinx-doc.org/en/master/usage/extensions/autodoc.html) extension and the neat [Furo](https://github.com/pradyunsg/furo) them. Use the `update-doc` make target to populate documentation source, and adapt the `index.rst` and `conf.py` files as needed.

Use a [GitHub Action](https://github.com/peaceiris/actions-gh-pages) to deploy the documentation on GitHub Pages (see example [here](https://github.com/Parici75/statsplotly/blob/main/.github/workflows/sphinx.yml)).


## 🔩 Dissecting Makefile
The Makefile provides several targets to assist in development and code quality :
- `init` creates a project-specific virtual environment, sync dependencies & initialize pre-commit
- `ci` launches ruff, mypy and pytest on your source code.
- `pre-commit` set up and/or update pre-commit hooks (see pre-commit [documentation](https://pre-commit.com/)) and run them on all your *staged* files.
- `coverage` run tests under coverage and produces a [coverage report](https://coverage.readthedocs.io/en/7.5.0/).
- `update-doc` and `build-doc` updates and builds your documentation with [Sphinx](https://www.sphinx-doc.org/en/master/) for local previsualisation.
- `clean` clears bytecode, poetry/pip caches, and pre-commit hooks. Use with caution.


## 🚛 Adapting and Extending this template
- Add dependencies:
```bash
uv add <package>
uv add --group dev <package>
```

- Build or publish:
```bash
uv build
uv publish
```


## Credits
This template is ported from my original [Python-poetry bootstrap template](https://github.com/Parici75/python-poetry-bootstrap), now rebuilt with uv + Hatch for modern performance and simplicity.
