# ---- Base Image ----
FROM python:3.10-slim

# Set work directory inside container
WORKDIR /app

# Install Python packages
COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy all project files
COPY . .

# Optional healthcheck (you can remove if not needed)
HEALTHCHECK --interval=30s --timeout=3s CMD curl --fail http://localhost:${PORT:-8000}/docs || exit 1

# Start FastAPI server using the dynamically assigned PORT from Railway
CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
