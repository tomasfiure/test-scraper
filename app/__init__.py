from flask import Flask

def create_app():
    """
    Factory function to create and configure the Flask app.
    """
    app = Flask(__name__)

    # Import and register blueprints or routes
    from .routes import scraper_bp
    app.register_blueprint(scraper_bp)

    return app
