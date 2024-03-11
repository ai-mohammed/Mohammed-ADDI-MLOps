# Use the official lightweight Python image.
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install Poetry
RUN pip install poetry

# Copy the pyproject.toml and poetry.lock files (if available) into the container
COPY pyproject.toml poetry.lock* /app/

# Disable virtualenv creation by Poetry and install dependencies globally
RUN poetry config virtualenvs.create false && \
    poetry install --no-root --no-dev

# Copy the rest of your application's code into the container
COPY . /app

# Expose the Streamlit port
EXPOSE 8501

# Command to run on container start
CMD ["streamlit", "run", "app.py"]
