from sqlalchemy import Column, String, Float
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()


class MapStateCountiesTable(Base):
    __tablename__ = 'mapping_by_state_county'
    __table_args__ = {'schema': 'mapping'}

    aurora_id = Column(String, primary_key=True, nullable=False)
    state = Column(String, nullable=False)
    county = Column(String, nullable=False)
    sTaxOilPercent = Column(Float, nullable=False)
    sTaxGasPercent = Column(Float, nullable=False)
    sTaxNglPercent = Column(Float, nullable=False)
