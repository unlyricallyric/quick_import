from sqlalchemy import Column, String, Float, Boolean
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class NglRegionsTable(Base):
    __tablename__ = 'ngl_by_region'
    __table_args__ = {'schema': 'ngl'}

    aurora_id = Column(String, primary_key=True, nullable=False)
    regionName = Column(String, nullable=False)
    composition = Column(String, nullable=False)
    nglYield = Column(Float, nullable=False)
    gasShrink = Column(Float, nullable=False)
    procFee = Column(Float, nullable=False)
    rangeStart = Column(Float, nullable=False)
    rangeEnd = Column(Float, nullable=False)
    isStartIncl = Column(Boolean, nullable=False)
    isEndIncl = Column(Boolean, nullable=False)
