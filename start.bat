@echo off
echo 🚀 Starting TurfBook Application...

REM Check if Python is installed
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python is not installed. Please install Python 3.8+ first.
    pause
    exit /b 1
)

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed. Please install Node.js 16+ first.
    pause
    exit /b 1
)

echo 📦 Setting up Backend...
cd backend

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate virtual environment
call venv\Scripts\activate.bat

REM Install dependencies
echo Installing Python dependencies...
pip install -r requirements.txt

REM Create .env file if it doesn't exist
if not exist ".env" (
    echo Creating .env file...
    (
        echo DATABASE_URL=sqlite:///./turfbook.db
        echo SECRET_KEY=your-secret-key-here-change-in-production
        echo ALGORITHM=HS256
        echo ACCESS_TOKEN_EXPIRE_MINUTES=30
        echo STRIPE_SECRET_KEY=your-stripe-secret-key
        echo STRIPE_PUBLISHABLE_KEY=your-stripe-publishable-key
        echo STRIPE_WEBHOOK_SECRET=your-stripe-webhook-secret
    ) > .env
    echo ✅ Created .env file. Please update with your actual Stripe keys.
)

REM Start backend server
echo 🚀 Starting Backend Server...
start "Backend Server" python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000

echo 📦 Setting up Frontend...
cd ..\frontend

REM Install dependencies
echo Installing Node.js dependencies...
npm install

REM Create .env file if it doesn't exist
if not exist ".env" (
    echo Creating frontend .env file...
    (
        echo REACT_APP_API_URL=http://localhost:8000
        echo REACT_APP_STRIPE_PUBLISHABLE_KEY=your-stripe-publishable-key
    ) > .env
    echo ✅ Created frontend .env file. Please update with your actual Stripe key.
)

REM Start frontend server
echo 🚀 Starting Frontend Server...
start "Frontend Server" npm start

echo ✅ TurfBook is starting up!
echo 📱 Frontend: http://localhost:3000
echo 🔧 Backend API: http://localhost:8000
echo 📚 API Docs: http://localhost:8000/docs
echo.
echo Both servers are now running in separate windows.
echo Close the windows to stop the servers.
pause 