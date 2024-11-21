# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy requirements and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN playwright install --with-deps chromium

# Copy the app code into the container
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app using Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
