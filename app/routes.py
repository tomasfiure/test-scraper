from flask import Blueprint, request, jsonify
from .scraper import get_article_text

# Create a Flask blueprint
scraper_bp = Blueprint("scraper", __name__)

@scraper_bp.route("/scrape", methods=["GET"])
def scrape():
    url = request.args.get("url")
    if not url:
        return jsonify({"error": "URL parameter is required"}), 400

    # Use the scraper function to get the article text
    article_text = get_article_text(url)
    if article_text:
        return jsonify({"article_text": article_text}), 200
    else:
        return jsonify({"error": "Failed to retrieve article"}), 500
