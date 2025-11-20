from flask import Blueprint, render_template
from ..application.controllers import get_home_message

presentation_bp = Blueprint(
    'presentation', 
    __name__, 
    template_folder='templates', 
    static_folder='static'
)

@presentation_bp.route('/')
def index():
    message = get_home_message()
    return render_template('index.html', message=message)

