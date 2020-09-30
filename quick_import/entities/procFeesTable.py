from sqlalchemy import Column, String, Float
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class ProcFeesTable(Base):
    __tablename__ = 'proc_fee_by_play_op'
    __table_args__ = {'schema': 'ngl'}

    aurora_id = Column(String, primary_key=True, nullable=False)
    playName = Column(String, nullable=False)
    ticker = Column(String, nullable=False)
    composition = Column(String, nullable=False)
    procFee = Column(Float, nullable=False)
