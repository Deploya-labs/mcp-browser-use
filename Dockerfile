# Use the official Python 3.13 slim image as base
FROM python:3.13-slim

# Install system dependencies:
# - chromium and its driver for browser automation
# - Additional packages to support headless mode if needed
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      chromium \
      chromium-driver \
      xvfb \
      ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy the project files into the container
COPY . /app

# Upgrade pip and install project dependencies.
# This assumes your project uses pyproject.toml/requirements defined for uvx and related packages.
RUN pip install --upgrade pip && \
    pip install .

# Optionally expose the Chrome debugging port (default: 9222)
EXPOSE 9222

# Set environment variables as needed (adjust or override at runtime)
# For example, to run in headless mode and set a logging level:
ENV BROWSER_HEADLESS="true" \
    BROWSER_USE_LOGGING_LEVEL="info"

# Use the production command from your configuration:
# Here we run the MCP server via uvx.
CMD ["uvx", "mcp-server-browser-use"]
