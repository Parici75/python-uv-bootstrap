PACKAGE_NAME=libs

# Detect Python version
PYTHON_SHELL_VERSION := $(shell python --version | cut -d " " -f 2)

# CI variables
CI_EXCLUDED_DIRS = __pycache__ docs tests
CI_DIRECTORIES=$(filter-out $(CI_EXCLUDED_DIRS), $(foreach dir, $(dir $(wildcard */)), $(dir:/=)))

# Project targets

init:
	@echo "✅ Using Python $(PYTHON_SHELL_VERSION)"
	@uv sync --all-extras
	@uv run pre-commit install
	@uv run pre-commit autoupdate
	@echo "✅ Project initialized"


# CI targets

lint-%:
	@echo lint-"$*"
	@uv run ruff format "$*"
	@uv run ruff check "$*"
	@echo "    ✅ All good"

lint: $(addprefix lint-, $(CI_DIRECTORIES))

typecheck-%:
	@echo typecheck-"$*"
	@uv run mypy "$*"

typecheck: $(addprefix typecheck-, $(CI_DIRECTORIES))

test:
	@uv run pytest -s --rootdir ./ --cache-clear tests

ci: lint typecheck test

coverage:
	@uv run coverage run -m pytest
	@uv run coverage report


# Pre-commit hooks

set-pre-commit:
	@echo "Setting up pre-commit hooks..."
	@uv run pre-commit install
	@uv run pre-commit autoupdate

run-pre-commit:
	@uv run pre-commit run --all-files

pre-commit: set-pre-commit run-pre-commit


# Documentation

update-doc:
	@uv run sphinx-apidoc --module-first --no-toc --force -o docs/source src/$(PACKAGE_NAME)

build-doc:
	@uv run sphinx-build docs ./docs/_build/html/


# Cleaning

clean-python:
	@echo "🧹 Cleaning Python bytecode..."
	@uv run pyclean . --quiet

clean-cache:
	@echo "🧹 Cleaning cache..."
	@find . -regex ".*/\..*cache" -type d -print0 | xargs -0 rm -rf --
	@uv run pre-commit clean

clean-hooks:
	@echo "🧹 Cleaning hooks..."
	@rm -r ".git/hooks" ||:

# Global

clean: confirm clean-cache clean-python clean-hooks
	@echo "✨ All clean"
