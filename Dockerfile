FROM python:3.11-slim

# Install required dependencies for Playwright
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates && \
    apt-get clean

# Install Playwright dependencies
RUN apt-get update && apt-get install -y \
    libnss3 \
    libxss1 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libgdk-pixbuf2.0-0 \
    libgtk-3-0 \
    libx11-xcb1 \
    libxtst6 && \
    apt-get clean

# Install Playwright
RUN pip install playwright && playwright install

WORKDIR /app
COPY . /app

CMD ["gunicorn", "--bind", "0.0.0.0:8080", "main:app"]
