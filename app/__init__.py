from flask import Flask
from .config import Config
from .presentation.routes import presentation_bp

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    app.register_blueprint(presentation_bp)

    return app

