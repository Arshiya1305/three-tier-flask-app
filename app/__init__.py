from flask import Flask
from .config import Config
from app.data.database import db

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    # Register blueprints
    from .presentation.routes import presentation_bp
    app.register_blueprint(presentation_bp)

    return app

