# Stage 1: Builder (install dependencies + train model)
FROM python:3.9 as builder

WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    libgomp1 && \
    rm -rf /var/lib/apt/lists/*

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install Python dependencies
COPY pyproject.toml setup.py .
RUN pip install --no-cache-dir -e .

# Copy and run training (only if needed)
COPY pipeline/training_pipeline.py .
COPY data/processed/ ./data/processed/
RUN python pipeline/training_pipeline.py

# Stage 2: Runtime (slim production image)
FROM python:3.9-slim

WORKDIR /app

# Copy only necessary artifacts
COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /app/models ./models
COPY --from=builder /app/data/processed ./data/processed

# Copy application code
COPY src/ ./src/
COPY application.py .

# Runtime environment
ENV PATH="/opt/venv/bin:$PATH" \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

EXPOSE 5000
CMD ["python", "application.py"]