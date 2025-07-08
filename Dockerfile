# Use a lightweight Python base image
FROM python:3.10-slim

# Set environment variables to avoid .pyc files and ensure logs are printed
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set the working directory
WORKDIR /app

# Install system dependencies required by LightGBM and pip tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgomp1 build-essential gcc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Copy source code
COPY . .

# 🚀 Upgrade pip + setuptools + wheel (important for editable installs)
RUN pip install --no-cache-dir --upgrade pip setuptools wheel

# Install the Python package in editable mode
RUN pip install --no-cache-dir -e .

# Train the model before starting the app
RUN python pipeline/training_pipeline.py

# Expose the port used by the app
EXPOSE 5000

# Run the app
CMD ["python", "application.py"]
