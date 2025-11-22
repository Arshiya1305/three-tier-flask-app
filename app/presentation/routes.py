from flask import Blueprint, render_template

presentation_bp = Blueprint('presentation', __name__)

@presentation_bp.route('/')
def index():
    from ..application.controllers import get_home_message  # moved inside
    items = get_home_message()
    return render_template('index.html', items=items)

