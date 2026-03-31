# dao/user_dao.py
from models import User

def insert(session, name: str):
    user = User(name=name)
    session.add(user)
    session.flush()  # ID取得のため
    return user
