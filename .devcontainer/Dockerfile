# ===================================================================
# Base: Devcontainers Python (Ubuntu + Python 3.13)
# ===================================================================
FROM mcr.microsoft.com/devcontainers/python:3.13

# ===================================================================
# Install system dependencies required for cryptographic libraries
# ===================================================================
RUN apt-get update && apt-get install -y \
    libssl-dev \
    build-essential \
    libffi-dev \
    gpg \
    gpg-agent \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

