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
	
run-prometheus:
	@echo "Creating Docker network if not exists..."
	@docker network ls | grep my-network || docker network create my-network
	@echo "Stopping existing Prometheus container if running..."
	@docker stop my-prometheus || true
	@echo "Removing existing Prometheus container if exists..."
	@docker rm my-prometheus || true
	@echo "Starting Prometheus container..."
	@docker run -d --name my-prometheus --network=my-network -p 9090:9090 \
	-v $(shell pwd)/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus


build:
	@$(MAKE) init
	@echo "Building Docker image..."
	@docker build -t mohammedaddi/app .

push:
	@echo "Tagging Docker image..."
	@docker tag mohammedaddi/app:latest mohammedaddi/mlops:latest
	@echo "Pushing Docker image to Docker Hub..."
	@docker push mohammedaddi/mlops:latest

deploy:
	@echo "Deploying the Docker image..."
	docker-compose up -d

.PHONY: init prepare run check run-prometheus build
