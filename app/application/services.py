from app.data.models import Message
from app import db

def save_message(text):
    new_msg = Message(text=text)
    db.session.add(new_msg)
    db.session.commit()

def get_all_messages():
    return Message.query.all()

