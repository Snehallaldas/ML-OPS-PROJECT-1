FROM python:3.10-slim

# Add SSL configuration to fix pip installation issues
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHTTPSVERIFY=0 \
    CURL_CA_BUNDLE="" \
    REQUESTS_CA_BUNDLE=""

WORKDIR /app

# Try to install system dependencies with retry
RUN for i in {1..3}; do \
        apt-get update && \
        apt-get install -y --no-install-recommends libgomp1 ca-certificates && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* && \
        break || sleep 10; \
    done

# Configure pip to handle SSL issues
RUN pip config set global.trusted-host pypi.org && \
    pip config set global.trusted-host pypi.python.org && \
    pip config set global.trusted-host files.pythonhosted.org

COPY . .

# Add retry mechanism and timeout for pip installations
RUN pip install --no-cache-dir --upgrade pip --timeout=1000 --retries=10
RUN pip install --no-cache-dir -e . --timeout=1000 --retries=10

RUN python pipeline/training_pipeline.py

EXPOSE 5000

CMD ["python", "application.py"]