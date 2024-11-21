FROM python:3.11-slim

# Install required dependencies for glibc, playwright, and Python
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    libnss3 \
    libxss1 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxtst6 \
    curl \
    zlib1g-dev \
    && apt-get clean

# Upgrade glibc to version 2.28+
RUN wget -q -O /tmp/glibc.tar.gz http://ftp.gnu.org/gnu/libc/glibc-2.28.tar.gz && \
    tar -xzf /tmp/glibc.tar.gz -C /tmp && \
    cd /tmp/glibc-2.28 && \
    mkdir build && cd build && \
    ../configure --prefix=/usr && \
    make -j$(nproc) && \
    make install && \
    rm -rf /tmp/glibc*

# Install Playwright and its dependencies
RUN pip install --no-cache-dir playwright==1.39.0 && playwright install

WORKDIR /app

# Copy application files
COPY . .

# Expose port 8080
EXPOSE 8080

# Start the application with Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]

# FROM mcr.microsoft.com/playwright/python:v1.39.0-focal

# WORKDIR /app
# COPY . /app

# CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
