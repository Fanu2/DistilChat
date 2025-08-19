# Use an official Python runtime as a base image
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Copy requirements first for layer caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of your application code
COPY . .

# Expose port for FastAPI (adjust if different)
EXPOSE 8000

# Run FastAPI from main.py (FastAPI instance must be named 'app')
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
