# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables to prevent Python from writing .pyc files to disk
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory in the container
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Install MySQL client
RUN apt-get update \
    && apt-get install -y --no-install-recommends default-libmysqlclient-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the rest of the application code
COPY . /app/

# Expose port 8000 for the Django app
EXPOSE 8000

# Default command to run the Django application
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
