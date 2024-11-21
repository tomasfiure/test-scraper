# Article Scraper API

This is a Flask-based API that scrapes the text content of an article from a given URL using Playwright.

## Features
- Extracts article text from web pages.
- Removes text from hyperlinks within the article.
- Returns the article text as JSON.

## Endpoints
### `GET /scrape`
**Parameters:**
- `url` (query parameter): The URL of the article to scrape.

**Response:**
- `200 OK`: Article text successfully retrieved.
- `400 Bad Request`: Missing or invalid URL.
- `500 Internal Server Error`: Failed to retrieve the article.

## Running Locally
1. Clone the repository.
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
