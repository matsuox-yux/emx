# db.py
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

engine = create_engine(
    "postgresql+psycopg2://user:pass@host/db",
    pool_size=5,
    max_overflow=2,
    pool_pre_ping=True,  # 切断対策
)

SessionLocal = sessionmaker(bind=engine)
# NG session = Session() スレッドセーフでない
