from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import auth, turfs, bookings, rooms, payments, users
from app.database import engine
from app.models import Base, User, Turf, Booking, Room, RoomMember, Payment

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="TurfBook API",
    description="Online Turf Booking Application API",
    version="1.0.0"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router, prefix="/api/auth", tags=["Authentication"])
app.include_router(users.router, prefix="/api/users", tags=["Users"])
app.include_router(turfs.router, prefix="/api/turfs", tags=["Turfs"])
app.include_router(bookings.router, prefix="/api/bookings", tags=["Bookings"])
app.include_router(rooms.router, prefix="/api/rooms", tags=["Rooms"])
app.include_router(payments.router, prefix="/api/payments", tags=["Payments"])

@app.get("/")
async def root():
    return {"message": "Welcome to TurfBook API"}

@app.get("/health")
async def health_check():
    return {"status": "healthy"} 