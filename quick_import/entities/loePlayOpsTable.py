from sqlalchemy import Column, String, Float, Boolean
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class LoePlayOpsTable(Base):
    __tablename__ = 'loe_by_play_op'
    __table_args__ = {'schema': 'loe'}

    aurora_id = Column(String, primary_key=True, nullable=False)
    ticker = Column(String, nullable=False)
    playName = Column(String, nullable=False)
    liquidPercent = Column(Float, nullable=False)
    grossVarLOE = Column(Float, nullable=False)
    includeInReg = Column(Boolean, nullable=False)
