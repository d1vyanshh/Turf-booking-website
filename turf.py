from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime, Text, ForeignKey
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
from app.database import Base

class Turf(Base):
    __tablename__ = "turfs"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    description = Column(Text)
    address = Column(String, nullable=False)
    latitude = Column(Float)
    longitude = Column(Float)
    price_per_hour = Column(Float, nullable=False)
    size = Column(String)  
    surface_type = Column(String) 
    amenities = Column(Text) 
    opening_time = Column(String, default="06:00")  
    closing_time = Column(String, default="22:00")  
    is_active = Column(Boolean, default=True)
    owner_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    created_at = Column(DateTime(timezone=True), server_default=func.now())
    updated_at = Column(DateTime(timezone=True), onupdate=func.now())


    owner = relationship("User", back_populates="turfs")
    bookings = relationship("Booking", back_populates="turf")
    rooms = relationship("Room", back_populates="turf") 