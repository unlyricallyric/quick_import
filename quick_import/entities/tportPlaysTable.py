from sqlalchemy import Column, String, Float
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class TportPlaysTable(Base):
    __tablename__ = 'tport_by_play'
    __table_args__ = {'schema': 'transportation'}

    aurora_id = Column(String, primary_key=True, nullable=False)
    playName = Column(String, nullable=False)
    regionName = Column(String, nullable=False)
    minResult = Column(Float, nullable=False)
    maxResult = Column(Float, nullable=False)
