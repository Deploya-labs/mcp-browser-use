# Use the official Python 3.13 slim image as base
FROM python:3.13-slim

# Install system dependencies: Chromium, its driver, Xvfb for headless operation, and ca-certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      chromium \
      chromium-driver \
      xvfb \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy project files into the container
COPY . /app

# Install uv (fast Python package installer) using pip
RUN pip install --upgrade pip && pip install uv

# Install project dependencies using uv's pip command
RUN uv pip install .

# Expose the port that the server will listen on (likely 8000)
EXPOSE 8000

# Set environment variables as needed (adjust as necessary)
ENV BROWSER_HEADLESS="true" \
    BROWSER_USE_LOGGING_LEVEL="info"

# Use the script entry point directly as defined in pyproject.toml
CMD ["mcp-server-browser-use"]
