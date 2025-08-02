# TurfBook Setup Guide

This guide will help you set up and run the TurfBook application on your local machine.

## Prerequisites

Before you begin, make sure you have the following installed:

- **Python 3.8+** - [Download Python](https://www.python.org/downloads/)
- **Node.js 16+** - [Download Node.js](https://nodejs.org/)
- **Git** - [Download Git](https://git-scm.com/)

## Quick Start (Recommended)

### For Windows Users:
1. Double-click `start.bat` in the project root
2. The script will automatically set up everything and start both servers

### For Mac/Linux Users:
1. Open terminal in the project root
2. Make the script executable: `chmod +x start.sh`
3. Run: `./start.sh`

## Manual Setup

If you prefer to set up manually or the automatic scripts don't work, follow these steps:

### Backend Setup

1. **Navigate to backend directory:**
   ```bash
   cd backend
   ```

2. **Create virtual environment:**
   ```bash
   python -m venv venv
   ```

3. **Activate virtual environment:**
   - Windows: `venv\Scripts\activate`
   - Mac/Linux: `source venv/bin/activate`

4. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

5. **Create environment file:**
   Create a `.env` file in the backend directory with:
   ```env
   DATABASE_URL=sqlite:///./turfbook.db
   SECRET_KEY=your-secret-key-here-change-in-production
   ALGORITHM=HS256
   ACCESS_TOKEN_EXPIRE_MINUTES=30
   STRIPE_SECRET_KEY=your-stripe-secret-key
   STRIPE_PUBLISHABLE_KEY=your-stripe-publishable-key
   STRIPE_WEBHOOK_SECRET=your-stripe-webhook-secret
   ```

6. **Start backend server:**
   ```bash
   python -m uvicorn app.main:app --reload
   ```

### Frontend Setup

1. **Navigate to frontend directory:**
   ```bash
   cd frontend
   ```

2. **Install dependencies:**
   ```bash
   npm install
   ```

3. **Create environment file:**
   Create a `.env` file in the frontend directory with:
   ```env
   REACT_APP_API_URL=http://localhost:8000
   REACT_APP_STRIPE_PUBLISHABLE_KEY=your-stripe-publishable-key
   ```

4. **Start frontend server:**
   ```bash
   npm start
   ```

## Accessing the Application

Once both servers are running:

- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:8000
- **API Documentation:** http://localhost:8000/docs

## Stripe Integration (Optional)

To enable payment functionality:

1. Create a Stripe account at [stripe.com](https://stripe.com)
2. Get your API keys from the Stripe Dashboard
3. Update the `.env` files with your actual Stripe keys:
   - `STRIPE_SECRET_KEY` (backend)
   - `STRIPE_PUBLISHABLE_KEY` (both frontend and backend)
   - `STRIPE_WEBHOOK_SECRET` (backend)

## Database

The application uses SQLite by default, which is perfect for development. The database file will be created automatically when you first run the application.

For production, you can switch to PostgreSQL or MySQL by updating the `DATABASE_URL` in the backend `.env` file.

## Features

### For Players:
- Browse available turfs
- Check slot availability
- Book turfs for specific time slots
- Create rooms for group bookings
- Join existing rooms and split payments
- Payment integration with Stripe
- Booking history and management

### For Turf Owners:
- Dashboard with financial analytics
- Real-time booking notifications
- Turf management (add, edit, remove turfs)
- Revenue tracking (daily, weekly, monthly)
- Booking calendar view
- Customer management

## Troubleshooting

### Common Issues:

1. **Port already in use:**
   - Backend: Change port in uvicorn command or kill process using port 8000
   - Frontend: Change port in package.json or kill process using port 3000

2. **Module not found errors:**
   - Make sure virtual environment is activated
   - Reinstall dependencies: `pip install -r requirements.txt`

3. **Node modules issues:**
   - Delete `node_modules` folder and `package-lock.json`
   - Run `npm install` again

4. **Database issues:**
   - Delete the `turfbook.db` file and restart the backend server

### Getting Help:

- Check the API documentation at http://localhost:8000/docs
- Review the console logs for error messages
- Ensure all environment variables are properly set

## Development

### Project Structure:
```
turfbook/
├── backend/                 # Python FastAPI backend
│   ├── app/
│   │   ├── models/         # Database models
│   │   ├── routes/         # API routes
│   │   ├── schemas/        # Pydantic schemas
│   │   └── utils/          # Utility functions
│   └── requirements.txt    # Python dependencies
├── frontend/               # React frontend
│   ├── src/
│   │   ├── components/     # React components
│   │   ├── pages/          # Page components
│   │   ├── services/       # API services
│   │   └── hooks/          # Custom hooks
│   └── package.json        # Node.js dependencies
└── README.md              # Project documentation
```

### Adding New Features:

1. **Backend:** Add new models, routes, and schemas in the appropriate directories
2. **Frontend:** Add new components and pages in the src directory
3. **Database:** Use Alembic for migrations (set up separately if needed)

## Deployment

For production deployment:

1. **Backend:** Deploy to services like Heroku, Railway, or AWS
2. **Frontend:** Build with `npm run build` and deploy to Netlify, Vercel, or AWS
3. **Database:** Use PostgreSQL or MySQL instead of SQLite
4. **Environment:** Set proper environment variables for production

## License

This project is licensed under the MIT License. 