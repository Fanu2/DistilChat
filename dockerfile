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

# Expose port for FastAPI (you can change to 8501 for Streamlit or run both)
EXPOSE 8000

# Change the CMD below depending on what you want Railway to run by default:
# Option A: Run your FastAPI app (if entry point is app.py and FastAPI instance is named "app")
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]

# Option B: To run Streamlit app instead, comment the above and uncomment below:
# CMD ["streamlit", "run", "app.py", "--server.port=8000", "--server.address=0.0.0.0"]
