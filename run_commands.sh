#!/bin/bash

# Load pyenv automatically by appending
# the following to ~/.bashrc:

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
# Initialize pyenv
echo "Initializing pyenv..."
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv install -s 3.11.6
pyenv local 3.11.6

# Setup Poetry environment
echo "Setting up Poetry environment..."
poetry config virtualenvs.prefer-active-python true
poetry config virtualenvs.in-project true
poetry install --no-root

# Run Streamlit app
echo "Running Streamlit app..."
poetry run streamlit run app.py

# Check code quality
echo "Checking code quality..."
poetry run vulture .
poetry run isort .
poetry run black .
poetry run mypy .

# Creating Docker network if not exists
echo "Creating Docker network if not exists..."
docker network ls | grep my-network || docker network create my-network
echo "Stopping existing Prometheus container if running..."
docker stop my-prometheus || true
echo "Removing existing Prometheus container if exists..."
docker rm my-prometheus || true
echo "Starting Prometheus container..."
docker run -d --name my-prometheus --network=my-network -p 9090:9090 -v "$(pwd)"/prometheus.yml:/etc/prometheus/prometheus.yml prom/prometheus

# Building Docker image
echo "Building Docker image..."
docker build -t mohammedaddi/app .
