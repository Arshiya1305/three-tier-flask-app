from app.data.models import Item

def get_home_message():
    return Item.query.all()

