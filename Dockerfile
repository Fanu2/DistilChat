# ---- Base Image ----
FROM python:3.10-slim

# ---- Set work directory ----
WORKDIR /app

# ---- Install dependencies ----
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# ---- Copy application code ----
COPY . .

# ---- Health Check (optional) ----
HEALTHCHECK --interval=30s --timeout=3s CMD curl --fail http://localhost:${PORT:-8000}/docs || exit 1

# ---- Start FastAPI using the PORT environment variable ----
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
