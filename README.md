# Real-Time Analytics Dashboard

A real-time analytics dashboard that monitors website traffic metrics including active users, page views, and average session duration.

## Features

- 📊 Real-time data visualization
- 👥 Active users counter
- 📈 Page views chart
- ⏱️ Average session duration gauge
- 🔄 Automatic data updates

## Tech Stack

### Frontend
- Flutter
- fl_chart (for data visualization)
- Provider (for state management)
- WebSocket (for real-time communication)

### Backend
- Node.js
- Express.js
- WebSocket (for real-time updates)

## Project Structure

```
.
├── frontend/           # Flutter frontend application
│   ├── lib/
│   │   ├── widgets/   # Reusable UI widgets
│   │   ├── screens/   # Screen widgets
│   │   ├── services/  # API services
│   │   └── utils/     # Utility functions
│   └── pubspec.yaml
├── backend/           # Node.js backend server
│   ├── src/
│   │   ├── routes/    # API routes
│   │   ├── services/  # Business logic
│   │   └── utils/     # Utility functions
│   └── package.json
└── README.md
```

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Node.js (v14 or higher)
- npm or yarn

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   # Install frontend dependencies
   cd frontend
   flutter pub get

   # Install backend dependencies
   cd ../backend
   npm install
   ```

### Running the Application

1. Start the backend server:
   ```bash
   cd backend
   npm start
   ```

2. Start the Flutter application:
   ```bash
   cd frontend
   flutter run
   ```

3. The application will launch on your default device/emulator

## Architecture

The application follows a client-server architecture with real-time data updates:

1. **Frontend**: Flutter-based UI that displays real-time metrics
2. **Backend**: Node.js server that generates and serves mock data
3. **Real-time Updates**: WebSocket connection for live data streaming

### Data Flow
1. Backend generates mock data at regular intervals
2. Data is sent to connected clients via WebSocket
3. Frontend widgets update in real-time to reflect new data

## Mock Data Structure

```json
{
  "timestamp": "2025-04-11T12:01:00Z",
  "active_users": 87,
  "page_views": 152,
  "avg_session_duration": 4.6
}
```

## Future Improvements

- Add authentication and user management
- Implement data persistence
- Add more detailed analytics
- Support custom date ranges
- Add export functionality for reports 