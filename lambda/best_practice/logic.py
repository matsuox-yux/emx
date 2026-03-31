# logic/user.py
from db import SessionLocal
from dao import user_dao

def create_user(name: str):
    with SessionLocal() as session:
        try:
            with session.begin():  # ← ここ重要
                user = user_dao.insert(session, name)
                return user

        except Exception:
            # rollbackは自動
            raise
