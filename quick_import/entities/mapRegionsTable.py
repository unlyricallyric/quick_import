from sqlalchemy import Column, String, Float
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class MapRegionsTable(Base):
    __tablename__ = 'mapping_by_region'
    __table_args__ = {'schema': 'mapping'}

    aurora_id = Column(String, primary_key=True, nullable=False)
    regionName = Column(String, nullable=False)
    rrOilPercent = Column(Float, nullable=False)
    rrGasPercent = Column(Float, nullable=False)
    rrNglPercent = Column(Float, nullable=False)
    oilDifferential = Column(Float, nullable=False)
    gasDifferential = Column(Float, nullable=False)
    nglDifferential = Column(Float, nullable=False)
    oilDifferentialPercent = Column(Float, nullable=False)
    gasDifferentialPercent = Column(Float, nullable=False)
    nglDifferentialPercent = Column(Float, nullable=False)
    fixedLoe = Column(Float, nullable=True)
