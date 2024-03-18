# Mohammed-ADDI-MLOps

## Overview

This project showcases a Streamlit application that visualizes housing data, featuring Prometheus for metrics monitoring. Designed for ease of use and deployment, it leverages Docker to containerize both the application and its monitoring components. This setup is ideal for developers seeking a straightforward method to deploy data visualization apps with built-in metrics tracking.

## Key Features

- **Data Visualization**: Utilize Streamlit for interactive data visualization.
- **Monitoring and Metrics**: Track user interactions and app performance with Prometheus.
- **Docker Integration**: Simplify deployment and scaling with Docker containers for both the app and Prometheus.

## Getting Started

### Prerequisites

- Docker installed on your system.
- Python 3.11.6 for local development (optional if using Docker).
- Poetry for Python dependency management (optional for local development).

### Installation & Setup

1. **Clone the Repository**

   Start by cloning this repository to your local machine.

   ```bash
   git clone https://github.com/your-username/your-repo-name.git
   cd your-repo-name
   ```


#### Local Environment Setup (Optional)

If you prefer to run the application locally for development:

    Ensure pyenv and Poetry are installed.

    Initialize the project environment:

    ```bash
    make init
    make prepare
    ```

### Running the Application

#### Using Docker (Recommended)

    The application and Prometheus can be easily run using Docker:

    ```bash
    # Build the Streamlit app Docker image
    make build

    # Run the Streamlit app container
    make run

    # Run the Prometheus container
    make run-prometheus
    ```
Visit http://localhost:8501 for the Streamlit app, and http://localhost:9090 for Prometheus 

#### Locally (For Development)

To run the Streamlit app locally for development purposes:

    ```bash

    make run
    ```
### Monitoring with Prometheus

Prometheus is configured to scrape metrics from the Streamlit application. Refer to prometheus.yml for the configuration setup.

    Access Prometheus UI: Navigate to http://localhost:9090.
    Metrics Exploration: Use Prometheus's query language to explore and visualize metrics from the Streamlit app.


Contributing

I welcome contributions to improve this project. Feel free to fork the repository, make your changes, and submit a pull request. For major changes or enhancements, please open an issue first to discuss your ideas.