# Use an official Python runtime as a base image
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

# Healthcheck — Railway will ping this URL to see if it's alive
# It checks every 30 seconds, timeout 3 seconds
HEALTHCHECK --interval=30s --timeout=3s CMD curl --fail http://localhost:${PORT:-8000}/docs || exit 1

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port $PORT"]
