SHELL := /bin/bash
PYENV_ROOT := $(HOME)/.pyenv
PATH := $(PYENV_ROOT)/bin:$(PATH)
PYTHON_VERSION := 3.11.6

export PATH
export PYENV_ROOT

init:
	@echo "Initializing pyenv..."
	@eval "$$(pyenv init --path)"
	@eval "$$(pyenv init -)"
	@eval "$$(pyenv virtualenv-init -)"
	@pyenv install -s $(PYTHON_VERSION)
	@pyenv local $(PYTHON_VERSION)

prepare:
	@$(MAKE) init
	@echo "Setting up Poetry environment..."
	@poetry config virtualenvs.prefer-active-python true
	@poetry config virtualenvs.in-project true
	@poetry install --no-root

run:
	@$(MAKE) init
	@echo "Running Streamlit app..."
	@poetry run streamlit run app.py

check:
	@$(MAKE) init
	@echo "Checking code quality..."
	@poetry run vulture .
	@poetry run isort .
	@poetry run black .
	@poetry run mypy .

build:
	@$(MAKE) init
	@echo "Building Docker image..."
	@docker build -t mohammedaddi/app .

.PHONY: init prepare run check build
